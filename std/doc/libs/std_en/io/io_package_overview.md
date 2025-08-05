# std.io

## Functionality Overview

The io package provides capabilities for data exchange between programs and external devices.

I/O operations refer to data exchange operations between programs and external devices. Cangjie offers generic interfaces for stream-based I/O operations along with some specialized implementations. Input/output streams function like data channels that carry ordered data sequences. Programs read data from input streams (from files, networks, etc.) and write data to output streams (to files, networks, etc.).

## API List

### Functions

|              Function Name             |             Functionality          |
| ------------------------------------- | --------------------------------- |
| [copy(InputStream, OutputStream)](./io_package_api/io_package_funcs.md#func-copyinputstream-outputstream) | Copies unread data from one input stream to another output stream. |
| [readString\<T>(T) where T <: InputStream & Seekable](./io_package_api/io_package_funcs.md#func-readstringtt-where-t--inputstream--seekable) | Reads all remaining content from the parameter and returns a string. |
| [readStringUnchecked\<T>(T) where T <: InputStream & Seekable](./io_package_api/io_package_funcs.md#func-readstringuncheckedtt-where-t--inputstream--seekable) | Reads all remaining content from the parameter and returns a string. This function does not validate string legality. |
| [func readToEnd\<T>(T) where T <: InputStream & Seekable](./io_package_api/io_package_funcs.md#func-readtoendtt-where-t--inputstream--seekable) | Retrieves all unread data from the parameter. |

### Interfaces

|              Interface Name         |           Functionality         |
| ---------------------------------- | ------------------------------- |
| [InputStream](./io_package_api/io_package_interfaces.md#interface-inputstream) | Input stream interface. |
| [IOStream](./io_package_api/io_package_interfaces.md#interface-iostream) | Input/output stream interface. |
| [OutputStream](./io_package_api/io_package_interfaces.md#interface-iostream) | Output stream interface. |
| [Seekable](./io_package_api/io_package_interfaces.md#interface-seekable) | Cursor movement interface. |

### Classes

|              Class Name         |           Functionality         |
| ---------------------------------- | ------------------------------- |
| [BufferedInputStream\<T> where T <: InputStream](./io_package_api/io_package_classes.md#class-bufferedinputstreamt-where-t--inputstream) | Provides buffered input stream. |
| [BufferedOutputStream\<T> where T <: OutputStream](./io_package_api/io_package_classes.md#class-bufferedoutputstreamt-where-t--outputstream) | Provides buffered output stream. |
| [ByteBuffer](./io_package_api/io_package_classes.md#class-bytebuffer) | Input stream interface. |
| [ChainedInputStream\<T> where T <: InputStream](./io_package_api/io_package_classes.md#class-chainedinputstreamt-where-t--inputstream) | Enables sequential data reading from an array of InputStreams. |
| [MultiOutputStream\<T> where T <: OutputStream](./io_package_api/io_package_classes.md#class-multioutputstreamt-where-t--outputstream) | Enables simultaneous data writing to each output stream in an OutputStream array. |
| [StringReader\<T> where T <: InputStream](./io_package_api/io_package_classes.md#class-stringreadert-where-t--inputstream) | Provides capability to read data from InputStream and convert it to characters or strings. |
| [StringWriter\<T> where T <: OutputStream](./io_package_api/io_package_classes.md#class-stringwritert-where-t--outputstream) | Provides capability to convert String and ToString-compatible types into strings with specified encoding format and endianness configuration, then write to output stream. |

### Enums

|              Enum Name         |           Functionality         |
| ---------------------------------- | ------------------------------- |
| [SeekPosition](./io_package_api/io_package_enums.md#enum-seekposition) | Input stream interface. |

### Exception Classes

|              Exception Class Name         |           Functionality         |
| ---------------------------------- | ------------------------------- |
| [ContentFormatException](./io_package_api/io_package_exceptions.md#class-contentformatexception) | Provides character format-related exception handling. |
| [IOException](./io_package_api/io_package_exceptions.md#class-ioexception) | Provides I/O stream-related exception handling. |