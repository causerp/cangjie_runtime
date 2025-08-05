# Usage of Dynamic Loading

Create two directories `myModuleDirectory` and `myExecutableDirectory` under the project root directory `myProject`. Use `cjpm` to build a Cangjie dynamic library module and an executable file respectively. The executable file will operate on global variables in the dynamic library module through reflection after dynamically loading it.

```bash
$ mkdir -p myProject && cd myProject
$ mkdir -p myPackage && cd myPackage
# Execute this command in the myPackage directory to initialize the directory structure of the Cangjie dynamic library module, enabling dynamic compilation of Cangjie functionalities in myPackage.
$ cjpm init --type=dynamic --name myPackage
cjpm init success
$ cat << EOF > src/myPackage.cj
package myPackage

public var myPublicGlobalVariable0: Int64 = 2333
public let myPublicGlobalVariable1 = MyPublicType("Initializing myPublicGlobalVariable1 in myPackage")

public class MyPublicType {
    public MyPublicType(message: String) {
        println(message)
    }

    public static func myPublicStaticMemeberFunction() {
        println("myPackage.MyPublicType.myPublicStaticMemeberFunction is called.")
    }

    static let myStaticVariable = MyPublicType("Initializing myStaticVariable in myPackage.MyPublicType")
}
EOF
# Use cjpm to build this Cangjie dynamic library module.
$ cjpm build
cjpm build success
$ cd .. && mkdir -p myExecutableDirectory && cd myExecutableDirectory
$ cjpm init
$ cat << EOF > src/main.cj
package myExecutableDirectory
import std.reflect.*

main(): Unit {
    // Load the Cangjie dynamic library.
    let myPackage = PackageInfo.load("../myPackage/target/release/myPackage/libmyPackage")
    println(myPackage.name)
    TypeInfo.get("myPackage.MyPublicType") |> println

    let myPublicGlobalVariable0 = myPackage.getVariable("myPublicGlobalVariable0")
    (myPublicGlobalVariable0.getValue() as Int64).getOrThrow() |> println
    myPublicGlobalVariable0.setValue(666)
    (myPublicGlobalVariable0.getValue() as Int64).getOrThrow() |> println
}
EOF

# Build and run the executable program.
$ cjpm run
Initializing myPublicGlobalVariable1 in myPackage
Initializing myStaticVariable in myPackage.MyPublicType
myPackage
myPackage.MyPublicType
2333
666

cjpm run finished
$ tree ..
..
├── myExecutableDirectory
│   ├── cjpm.lock
│   ├── cjpm.toml
│   ├── src
│   │   └── main.cj
│   └── target
│       └── release
│           ├── bin
│           │   ├── main
│           │   ├── myExecutableDirectory.bchir
│           │   └── myExecutableDirectory.cjo
│           ├── myExecutableDirectory
│           │   └── incremental-cache.json
│           └── myExecutableDirectory-cache.json
└── myPackage
    ├── cjpm.lock
    ├── cjpm.toml
    ├── src
    │   └── myPackage.cj
    └── target
        └── release
            ├── bin
            ├── myPackage
            │   ├── incremental-cache.json
            │   ├── libmyPackage.so
            │   ├── myPackage.bchir
            │   └── myPackage.cjo
            └── myPackage-cache.json

12 directories, 16 files
```

> **Note:**
>
> Since the current PackageInfo.load function determines the package name based on the filename, modifying this filename is not allowed. Otherwise, it will throw an exception indicating the Cangjie dynamic library module file cannot be found.