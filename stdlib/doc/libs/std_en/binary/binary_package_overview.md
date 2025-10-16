# std.binary

## Function Description

The current binary package provides the following functionalities:

- Interfaces for bidirectional conversion between Cangjie data types and binary byte sequences, supporting both big-endian and little-endian conversion types.
- Interfaces for endianness conversion of Cangjie data types themselves.

> **Note:**
>
> - Generally, multi-byte objects are stored as contiguous byte sequences. The ordering of bytes in memory or digital communication links is called endianness, also known as byte order.
> - There are two byte arrangement methods: storing the least significant byte at the lowest memory address (little-endian) or storing the most significant byte at the lowest memory address (big-endian).

## API List

### Interfaces

| Interface Name                                               | Functionality                     |
| ------------------------------------------------------------ | -------------------------------- |
| [BigEndianOrder\<T>](./binary_package_api/binary_package_interfaces.md#interface-bigendianordert) | Big-endian byte sequence conversion interface. |
| [LittleEndianOrder\<T>](./binary_package_api/binary_package_interfaces.md#interface-littleendianordert) | Little-endian byte sequence conversion interface. |
| [SwapEndianOrder\<T>](./binary_package_api/binary_package_interfaces.md#interface-swapendianordert) | Byte order reversal interface.       |