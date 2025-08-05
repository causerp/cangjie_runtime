# std.process

## Functionality Overview

The process package primarily provides Process operation interfaces, including process creation, standard stream acquisition, process waiting, and process information querying.

This package offers cross-platform unified control capabilities, currently supporting Linux, macOS, and Windows platforms.

## API List

### Functions

| Function Name | Functionality |
| ------------ | ------------ |
| [execute](./process_package_api/process_package_funcs.md#func-executestring-arraystring-path-mapstring-string-processredirect-processredirectprocessredirect-duration) | Creates and runs a child process based on input parameters, waits for its completion, and returns the child process exit status. |
| [executeWithOutput](./process_package_api/process_package_funcs.md#func-executewithoutputstring-arraystring-path-mapstring-string-processredirect-processredirect-processredirect) | Creates and runs a child process based on input parameters, waits for its completion, and returns the child process exit status, standard output, and standard error. |
| [findProcess](./process_package_api/process_package_funcs.md#func-findprocessint64) | Binds a process instance based on the input process ID. |
| [launch](./process_package_api/process_package_funcs.md#func-launchstring-arraystring-path-mapstring-string-processredirect-processredirect-processredirect) | Creates and runs a child process based on input parameters and returns a child process instance. |

### Classes

| Class Name | Functionality |
| ------------ | ------------ |
| [CurrentProcess <sup>(deprecated)</sup>](./process_package_api/process_package_classes.md#class-currentprocess-deprecated) | This class represents the current process, inherits from the `Process` class, and provides functionality for current process operations. |
| [Process](./process_package_api/process_package_classes.md#class-process) | This class represents a process and provides process operation functionality. |
| [SubProcess](./process_package_api/process_package_classes.md#class-subprocess) | This class represents a child process, inherits from the `Process` class, and provides functionality for child process operations. |

### Enums

| Enum Name | Functionality |
| --------------------------- | ------------------------ |
| [ProcessRedirect](./process_package_api/process_package_enums.md#enum-processredirect) | Used to set the redirection mode of child process standard streams during process creation. |

### Exception Classes

| Exception Class Name | Functionality |
| --------------------------- | ------------------------ |
| [ProcessException](./process_package_api/process_package_exceptions.md#class-processexception) | The exception class for the `process` package. |

### Compatibility Notes

#### class Process

| Member | Supported Platforms |
| ------------ | ------------ |
| [current <sup>(deprecated)</sup>](./process_package_api/process_package_classes.md#static-prop-current-deprecated) | `Linux` `Windows` `macOS` |
| [pid](./process_package_api/process_package_classes.md#prop-pid) | `Linux` `Windows` `macOS` |
| [name](./process_package_api/process_package_classes.md#prop-name) | `Linux` `Windows` `macOS` |
| [command](./process_package_api/process_package_classes.md#prop-command) | `Linux` `Windows` `macOS` |
| [arguments <sup>(deprecated)</sup>](./process_package_api/process_package_classes.md#prop-arguments-deprecated) | `Linux` `macOS` |
| [commandLine <sup>(deprecated)</sup>](./process_package_api/process_package_classes.md#prop-commandLine-deprecated) | `Linux` `macOS` |
| [environment <sup>(deprecated)</sup>](./process_package_api/process_package_classes.md#prop-environment-deprecated) | `Linux` |
| [workingDirectory <sup>(deprecated)</sup>](./process_package_api/process_package_classes.md#prop-workingDirectory-deprecated) | `Linux` `macOS` |
| [of(Int64) <sup>(deprecated)</sup>](./process_package_api/process_package_classes.md#static-func-ofint64-deprecated) | `Linux` `Windows` `macOS` |
| [start(String, Array\<String>, Path, Map\<String, String>, ProcessRedirect, ProcessRedirect, ProcessRedirect) <sup>(deprecated)</sup>](./process_package_api/process_package_classes.md#static-func-startstring-arraystring-path-mapstring-string-processredirect-processredirect-processredirect-deprecated) | `Linux` `Windows` `macOS` |
| [run(String, Array\<String>, Path, Map\<String, String>, ProcessRedirect, ProcessRedirect, ProcessRedirect, Duration) <sup>(deprecated)</sup>](./process_package_api/process_package_classes.md#static-func-runstring-arraystring-path-mapstring-string-processredirect-processredirectprocessredirect-duration-deprecated) | `Linux` `Windows` `macOS` |
| [runOutput(String, Array\<String>, Path, Map\<String, String>, ProcessRedirect, ProcessRedirect, ProcessRedirect) <sup>(deprecated)</sup>](./process_package_api/process_package_classes.md#static-func-runoutputstring-arraystring-path-mapstring-string-processredirect-processredirect-processredirect-deprecated) | `Linux` `Windows` `macOS` |
| [terminate(Bool)](./process_package_api/process_package_classes.md#func-terminatebool) | `Linux` `Windows` `macOS` |

#### class CurrentProcss <sup>(deprecated)</sup>

> **Note:**
>
> Will be deprecated in future versions. Alternative functionality can be found in std.env.

| Member | Supported Platforms |
| ------------ | ------------ |
| [arguments](./process_package_api/process_package_classes.md#prop-arguments) | `Linux` `Windows` `macOS` |
| [homeDirectory](./process_package_api/process_package_classes.md#prop-homeDirectory) | `Linux` `Windows` `macOS` |
| [tempDirectory](./process_package_api/process_package_classes.md#prop-tempDirectory) | `Linux` `Windows` `macOS` |
| [stdIn](./process_package_api/process_package_classes.md#prop-stdIn) | `Linux` `Windows` `macOS` |
| [stdOut](./process_package_api/process_package_classes.md#prop-stdOut) | `Linux` `Windows` `macOS` |
| [stdErr](./process_package_api/process_package_classes.md#prop-stdErr) | `Linux` `Windows` `macOS` |
| [atExit(() -> Unit)](./process_package_api/process_package_classes.md#func-atexit---unit) | `Linux` `Windows` `macOS` |
| [exit(Int64)](./process_package_api/process_package_classes.md#func-exitint64) | `Linux` `Windows` `macOS` |
| [getEnv(String)](./process_package_api/process_package_classes.md#func-getenvstring) | `Linux` `Windows` `macOS` |
| [removeEnv(String)](./process_package_api/process_package_classes.md#func-removeenvstring) | `Linux` `Windows` `macOS` |
| [setEnv(String, String)](./process_package_api/process_package_classes.md#func-setenvstring-string) | `Linux` `Windows` `macOS` |

#### class SubProcess

| Member | Supported Platforms |
| ------------ | ------------ |
| [stdIn <sup>(deprecated)</sup>](./process_package_api/process_package_classes.md#prop-stdIn-deprecated) | `Linux` `Windows` `macOS` |
| [stdInPipe](./process_package_api/process_package_classes.md#prop-stdinpipe) | `Linux` `Windows` `macOS` |
| [stdOut <sup>(deprecated)</sup>](./process_package_api/process_package_classes.md#prop-stdOut-deprecated) | `Linux` `Windows` `macOS` |
| [stdOutPipe](./process_package_api/process_package_classes.md#prop-stdoutpipe) | `Linux` `Windows` `macOS` |
| [stdErr <sup>(deprecated)</sup>](./process_package_api/process_package_classes.md#prop-stdErr-deprecated) | `Linux` `Windows` `macOS` |
| [stdErrPipe](./process_package_api/process_package_classes.md#prop-stderrpipe) | `Linux` `Windows` `macOS` |
| [wait(Duration)](./process_package_api/process_package_classes.md#func-waitduration) | `Linux` `Windows` `macOS` |
| [waitOutput()](./process_package_api/process_package_classes.md#func-waitoutput) | `Linux` `Windows` `macOS` |