# std.crypto.digest

## Function Overview

The `std.crypto.digest` package provides a common interface for widely-used digest algorithms, including MD5, SHA1, SHA224, SHA256, SHA384, SHA512, HMAC, SM3, and others.

## API List

### Functions

| Function Name | Description |
| --------------------------------- | ---------------------------------- |
| [digest\<T>(T, Array\<Byte>) where T <: Digest](./digest_package_api/digest_package_funcs.md#func-digesttt-arraybyte-where-t--digest) | Provides a generic `digest` function that performs digest computation using the specified digest algorithm. |
| [digest\<T>(T, String) where T <: Digest <sup>(deprecated)</sup>](./digest_package_api/digest_package_funcs.md#func-digesttt-string-where-t--digest) | Provides a generic `digest` function that performs digest computation using the specified digest algorithm. |
| [digest\<T>(T, InputStream) where T <: Digest](./digest_package_api/digest_package_funcs.md#func-digesttt-inputstream-where-t--digest) | Provides a generic `digest` function that performs digest computation on data from an InputStream using the specified digest algorithm. |

### Interfaces

| Interface Name | Description |
| --------------------------------- | ---------------------------------- |
| [Digest](./digest_package_api/digest_package_interfaces.md#interface-digest ) | This interface serves as the common interface for digest algorithms. |