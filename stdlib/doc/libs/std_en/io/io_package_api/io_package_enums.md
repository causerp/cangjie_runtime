# Enumeration

## enum SeekPosition

```cangjie
public enum SeekPosition {
    | Current(Int64)
    | Begin(Int64)
    | End(Int64)
}
```

Function: This enumeration type represents the cursor position in a file.

### Begin(Int64)

```cangjie
Begin(Int64)
```

Function: Indicates moving a specified length from the starting point.

### Current(Int64)

```cangjie
Current(Int64)
```

Function: Indicates moving a specified length from the current position.

### End(Int64)

```cangjie
End(Int64)
```

Function: Indicates moving a specified length from the end.