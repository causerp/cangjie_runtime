# Type Alias

## type CrossReferenceHandler

```cangjie
type CrossReferenceHandler = (ExportedRef, ForeignProxy) -> Unit
```

Function: Defines a function type for handling cross-heap circular references, with parameter types [ExportedRef](./interop_package_classes.md#class-exportedref) and [ForeignProxy](./interop_package_classes.md#class-foreignproxy). This function is strongly dependent on the language's internal implementation and is used to assist automatic memory management in analyzing garbage memory in cross-language circular references.