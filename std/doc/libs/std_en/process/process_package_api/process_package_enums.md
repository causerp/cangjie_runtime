# Enumeration

## enum ProcessRedirect

```cangjie
public enum ProcessRedirect {
    | Inherit
    | Pipe
    | FromFile(File)
    | Discard
}
```

Function: This enumeration type is used to configure the redirection mode of child process standard streams when creating a process.

### Discard

```cangjie
Discard
```

Function: Constructs a standard stream redirection enumeration instance, indicating that the child process's standard streams will be discarded. In this mode, the standard stream properties cannot be read or written.

### FromFile(File)

```cangjie
FromFile(File)
```

Function: Constructs a standard stream redirection enumeration instance, indicating that the child process's standard streams will be redirected to the specified file. Redirected standard input streams will read from the specified file, while redirected standard output or error streams will write to the specified file. The redirected file must exist and remain open; otherwise, redirection is not permitted. In this mode, the standard stream properties cannot be read or written. Parameter [File](../../fs/fs_package_api/fs_package_classes.md#class-file) refers to an existing and open file instance to which the child process's standard streams will be redirected during process creation.

### Inherit

```cangjie
Inherit
```

Function: Constructs a standard stream redirection enumeration instance, indicating that the child process's standard streams will inherit the current process's standard streams. In this mode, the standard stream properties cannot be read or written.

### Pipe

```cangjie
Pipe
```

Function: Constructs a standard stream redirection enumeration instance, indicating that the child process's standard streams will be redirected to pipes and connected to the current process through these pipes. Redirected standard input streams can write data to the child process through pipes, while redirected standard output or error streams can read the child process's output results through pipes. In this mode, data can be read from or written to the standard stream properties.