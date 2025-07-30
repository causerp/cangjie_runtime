# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

#!/usr/bin/env python3
import os
import sys
import subprocess
import platform
import shutil
import argparse

# Get the directory where the script is located as the execution directory
script_path = os.path.dirname(os.path.abspath(__file__))

def do_clean(args):
    # Remove specified directories
    dirs_to_remove = ["output", "CMakebuild", "build/cjthread_build"]
    for directory in dirs_to_remove:
        try:
            subprocess.run(["rm", "-rf", os.path.join(script_path, directory)], check=True)
        except subprocess.CalledProcessError as e:
            print(f"Error cleaning directory {directory}: {e}")
            sys.exit(1)
    print("Cleaned successfully.")
    sys.exit(0)

def do_build(args):
    # Get script arguments
    target_args = args.target
    mode = args.build_type
    version = args.version
    prefix_path = args.prefix

    if target_args == 'native':
        target_platform = platform.system().lower()
    else:
        target_platform =  target_args.split('-')[0]

    # Validate the version number parameter
    if not version:
        print("Parameter 3 - version number is empty, please enter the correct version number")
        sys.exit(1)

    # Define paths
    host_arch = platform.machine()
    host_os_name = platform.system().lower()

    # Adjust CMAKE_INSTALL_PREFIX based on target_args
    if target_platform == "ohos":
        install_prefix = os.path.join(prefix_path, f"linux_ohos_{mode}")
    else:
        install_prefix = os.path.join(prefix_path, f"{target_platform}_{mode}")

    # Remove output/temp directory before building
    temp_dir = os.path.join(script_path, "output/temp")
    cmakebuild_dir = os.path.join(script_path, "CMakebuild")
    try:
        if os.path.exists(temp_dir):
            shutil.rmtree(temp_dir)
        if os.path.exists(cmakebuild_dir):
            shutil.rmtree(cmakebuild_dir)
        print(f"Removed {temp_dir} & {cmakebuild_dir} directory successfully.")
    except Exception as e:
        print(f"Error removing {temp_dir} & {cmakebuild_dir} directory: {e}")
        sys.exit(1)

    if target_args in ('native'):
        target_arch = host_arch
    elif target_args in ('ohos-x86_64', 'ohos-aarch64', 'windows-x86_64'):
        target_arch = target_args.split('-', 1)[1]
    else:
        target_arch = None

    target_arch = target_arch.lower()
    if target_arch == "arm64":
        target_arch = "aarch64"
    elif target_arch == "amd64":
        target_arch = "x86_64"

    shared_linker_flags = ""
    exe_linker_flags = ""
    if target_platform in ('linux'):
        shared_linker_flags = "-Wl,--disable-new-dtags,-rpath=\\$ORIGIN"
        exe_linker_flags = "-Wl,--disable-new-dtags,-rpath=\\$ORIGIN/../../runtime/lib/linux_${CMAKE_SYSTEM_PROCESSOR}_cjnative"
    elif target_platform in ('darwin'):
        shared_linker_flags = "-Wl,-rpath,@loader_path"
        exe_linker_flags = "-Wl,-rpath,@loader_path/../../runtime/lib/darwin_${CMAKE_SYSTEM_PROCESSOR}_cjnative"
    elif target_platform in ('windows'):
        shared_linker_flags = "-Wl,--no-insert-timestamp"
        exe_linker_flags = "-Wl,--no-insert-timestamp"

    mode = mode.capitalize()
    macos_flag = 1 if platform.system().lower() == 'darwin' else 0
    # Perform different build actions based on the target_args
    if target_args == "native":
        cmake_command = [
            "cmake",
            "-DCMAKE_INSTALL_PREFIX={}_{}".format(install_prefix, target_arch),
            "-DCMAKE_BUILD_TYPE={}".format(mode),
            "-DCOPYGC_FLAG=1",
            "-DDOPRA_FLAG=1",
            "-DRTOS_FLAG=0",
            "-DRTOS_LINUX_KERNEL_FLAG=0",
            "-DOHOS_FLAG=0",
            "-DEULER_FLAG=0",
            "-DMACOS_FLAG={}".format(macos_flag),
            "-DRUNTIME_TRACE_FLAG=1",
            "-DASAN_FLAG=0",
            "-DHWASAN_FLAG={}".format(args.hwasan),
            "-DSANITIZER_SUPPORT=0",
            "-DCOV=0",
            "-DDUMPADDRESS_FLAG=0",
            "-DCJ_SDK_VERSION={}".format(version),
            "-DDISABLE_VERSION_CHECK=1",
            "-DCMAKE_C_COMPILER=clang",
            "-DCMAKE_CXX_COMPILER=clang++",
            "-DCMAKE_AR_PATH=ar",
            "-DCMAKE_SHARED_LINKER_FLAGS={}".format(shared_linker_flags),
            "-DCMAKE_EXE_LINKER_FLAGS={}".format(exe_linker_flags),
            "-S", ".", "-B", "CMakebuild"
        ]
        build_target(cmake_command)

    elif target_args == "windows-x86_64":
        if args.target_toolchain == None:
            print("Please configure windows toolchain, for example '/opt/buildtools/mingw-w64-v11.0.1'")
            sys.exit(1)
        os.environ["PATH"] = os.path.join(args.target_toolchain, "bin") + ":" + os.environ["PATH"]
        cmake_command = [
            "cmake",
            "-DCMAKE_INSTALL_PREFIX={}_{}".format(install_prefix, target_arch),
            "-DCMAKE_BUILD_TYPE={}".format(mode),
            "-DCOPYGC_FLAG=1",
            "-DDOPRA_FLAG=1",
            "-DRTOS_FLAG=0",
            "-DRTOS_LINUX_KERNEL_FLAG=0",
            "-DOHOS_FLAG=0",
            "-DEULER_FLAG=0",
            "-DWINDOWS_FLAG=1",
            "-DDSU_FLAG=0",
            "-DRUNTIME_TRACE_FLAG=1",
            "-DASAN_FLAG=0",
            "-DHWASAN_FLAG={}".format(args.hwasan),
            "-DSANITIZER_SUPPORT=0",
            "-DCOV=0",
            "-DDUMPADDRESS_FLAG=0",
            "-DCJ_SDK_VERSION={}".format(version),
            "-DDISABLE_VERSION_CHECK=1",
            "-DCMAKE_C_COMPILER=clang",
            "-DCMAKE_CXX_COMPILER=clang++",
            "-DCMAKE_AR_PATH=ar",
            "-DCMAKE_SHARED_LINKER_FLAGS={}".format(shared_linker_flags),
            "-DCMAKE_EXE_LINKER_FLAGS={}".format(exe_linker_flags),
            "-S", ".", "-B", "CMakebuild"
        ]
        build_target(cmake_command)

    elif target_args in ["ohos-aarch64", "ohos-x86_64"]:
        if args.target_toolchain == None:
            print("Please configure ohos toolchain, for example '/root/workspace/ohos_dep_files/'")
            sys.exit(1)
        ohos_flag = "1" if target_args == "ohos-aarch64" else "2"
        if target_args == "ohos-aarch64":
            target_arch = "aarch64"
        elif target_args == "ohos-x86_64":
            target_arch = "x86_64"
        ptrauth_flags = [
            "-DRUNTIME_FORWARD_PTRAUTH_CFI=1",
            "-DRUNTIME_BACKWARD_PTRAUTH_CFI=1",
        ] if target_args == "ohos-aarch64" else []
        cmake_command = [
            "cmake",
            "-DCMAKE_INSTALL_PREFIX={}_{}".format(install_prefix, target_arch),
            "-DCMAKE_BUILD_TYPE={}".format(mode),
            "-DCOPYGC_FLAG=1",
            "-DDOPRA_FLAG=1",
            "-DRTOS_FLAG=0",
            "-DRTOS_LINUX_KERNEL_FLAG=0",
            "-DOHOS_FLAG={}".format(ohos_flag),
            "-DOHOS_ROOT={}".format(args.target_toolchain),
            "-DEULER_FLAG=0",
            "-DRUNTIME_TRACE_FLAG=1",
            "-DASAN_FLAG=0",
            "-DHWASAN_FLAG={}".format(args.hwasan),
            "-DSANITIZER_SUPPORT=0",
            "-DCOV=0",
            "-DDUMPADDRESS_FLAG=0",
            "-DCJ_SDK_VERSION={}".format(version),
            "-DDISABLE_VERSION_CHECK=1",
            "-S", ".", "-B", "CMakebuild"
        ] + ptrauth_flags
        build_target(cmake_command)

    else:
        print("Invalid build target, build targets include: native, windows-x86_64, ohos-aarch64, ohos-x86_64")
        sys.exit(1)

def build_target(cmake_command):
    try:
        subprocess.run(cmake_command, check=True)

        build_dir = os.path.join(script_path, "CMakebuild")
        os.makedirs(build_dir, exist_ok=True)
        os.chdir(build_dir)

        subprocess.run(["make", "cangjie-runtime", "-j32", "VERBOSE=1"], check=True)

        subprocess.run(["make", "preinstall", "-j32", "VERBOSE=1"], check=True)

        print("Build and preinstall completed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error during build : {e}")
        sys.exit(1)
    finally:
        os.chdir(script_path)

def do_install(args):
    try:
        build_dir = os.path.join(script_path, "CMakebuild")
        os.makedirs(build_dir, exist_ok=True)
        os.chdir(build_dir)
        if args.prefix == "":
            subprocess.run(["cmake", "-P", "cmake_install.cmake"], check=True)
        else:
            subprocess.run(["cmake", "-DCMAKE_INSTALL_PREFIX={}".format(args.prefix), "-P", "cmake_install.cmake"], check=True)

        print("Install completed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error during install : {e}")
        sys.exit(1)
    finally:
        os.chdir(script_path)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="build / install / clean"
    )
    sub = parser.add_subparsers(dest="command", required=True)

    b = sub.add_parser("build", help="compile the project")
    b.set_defaults(func=do_build)
    b.add_argument(
        "--target",
        choices=["native", "windows-x86_64", "ohos-aarch64", "ohos-x86_64"],
        metavar="TARGET",
        default="native",
        help="Target platform: native, windows-x86_64, ohos-aarch64, ohos-x86_64"
    )
    b.add_argument(
        "-t", "--build-type",
        choices=["release", "debug", "relwithdebinfo"],
        default="release",
        help="Build build-type: release, debug, relwithdebinfo (default: release)"
    )
    b.add_argument(
        "-v", "--version",
        default="0.0.1",
        help="Version string, e.g., 0.0.1"
    )
    b.add_argument(
        "--prefix",
        default=os.path.join(script_path, "output", "common"),
        help="Specify the installation directory for the build artifacts."
    )
    b.add_argument(
        "-hwasan",
        action="store_true",
        help="Enable HWASAN"
    )
    b.add_argument(
        "--target-toolchain",
        help="The toolchain required for cross-compilation depends on the specific build target; please specify the appropriate toolchain according to each build-target."
    )

    i = sub.add_parser("install", help="install the project")
    i.set_defaults(func=do_install)
    i.add_argument(
        "--prefix",
        default="",
        help="Specify the installation directory for the build artifacts."
    )

    c = sub.add_parser("clean", help="remove build artifacts")
    c.set_defaults(func=do_clean)

    args = parser.parse_args()
    args.func(args)