# std.sort

## Function Overview

The sort package provides sorting functions for array types.

Based on the sorting method, this package offers two implementations: stable sort and unstable sort. A stable sort ensures that the relative order of equal elements remains unchanged before and after sorting. Conversely, an unstable sort does not guarantee that the relative order of equal elements will be preserved.

This package provides a set of generic sorting functions that can be used to sort arrays with elements of type `T`. Sorting inherently requires elements to be comparable. Therefore, these functions are further divided into two categories: 1) those requiring `T` to implement the `Comparable<T>` interface, and 2) those accepting a comparison function for `T` as a parameter.

Additionally, this package provides auxiliary interfaces `SortByExtension (to be deprecated in future versions)` and `SortExtension (to be deprecated in future versions)`, which can be used to implement sorting-related functions for other types.

## API List

### Functions

| Function Name | Description |
| --------------------------------- | ---------------------------------- |
| [sort\<T>(Array\<T>, Bool, Bool) where T <: Comparable\<T>](./sort_package_api/sort_package_funcs.md#func-sorttarrayt-bool-bool-where-t--comparablet) | Sorts an array. Parameters specify whether to perform a stable sort and whether to sort in ascending or descending order. |
| [sort\<T>(Array\<T>, (T, T) -> Ordering, Bool, Bool)](./sort_package_api/sort_package_funcs.md#func-sorttarrayt-t-t---ordering-bool-bool) | Sorts an array using a comparison function. Parameters specify whether to perform a stable sort and whether to sort in ascending or descending order. |
| [sort\<T>(Array\<T>, (T, T) -> Bool, Bool, Bool)](./sort_package_api/sort_package_funcs.md#func-sorttarrayt-t-t---bool-bool-bool) | Sorts an array using a comparison function. Parameters specify whether to perform a stable sort and whether to sort in ascending or descending order. |
| [sort\<T, K>(Array\<T>, (T) -> K, Bool, Bool) where K <: Comparable\<K>](./sort_package_api/sort_package_funcs.md#func-sortt-karrayt-t---k-bool-bool-where-k--comparablek) | Sorts an array by specified keys (where keys are comparable). Parameters specify whether to perform a stable sort and whether to sort in ascending or descending order. |
| [sort\<T>(ArrayList\<T>, Bool, Bool) where T <: Comparable\<T>](./sort_package_api/sort_package_funcs.md#func-sorttarraylistt-bool-bool-where-t--comparablet) | Sorts an `ArrayList`. Parameters specify whether to perform a stable sort and whether to sort in ascending or descending order. |
| [sort\<T>(ArrayList\<T>, (T, T) -> Ordering, Bool, Bool)](./sort_package_api/sort_package_funcs.md#func-sorttarraylistt-t-t---ordering-bool-bool) | Sorts an `ArrayList` using a comparison function. Parameters specify whether to perform a stable sort and whether to sort in ascending or descending order. |
| [sort\<T>(ArrayList\<T>, (T, T) -> Bool, Bool, Bool)](./sort_package_api/sort_package_funcs.md#func-sorttarraylistt-t-t---bool-bool-bool) | Sorts an `ArrayList` using a comparison function. Parameters specify whether to perform a stable sort and whether to sort in ascending or descending order. |
| [sort\<T, K>(ArrayList\<T>, (T) -> K, Bool, Bool) where K <: Comparable\<K>](./sort_package_api/sort_package_funcs.md#func-sortt-karraylistt-t---k-bool-bool-where-k--comparablek) | Sorts an `ArrayList` by specified keys (where keys are comparable). Parameters specify whether to perform a stable sort and whether to sort in ascending or descending order. |
| [sort\<T>(List\<T>, Bool, Bool) where T <: Comparable\<T>](./sort_package_api/sort_package_funcs.md#func-sorttlistt-bool-bool-where-t--comparablet) | Sorts a `List`. Parameters specify whether to perform a stable sort and whether to sort in ascending or descending order. |
| [sort\<T>(List\<T>, (T, T) -> Ordering, Bool, Bool)](./sort_package_api/sort_package_funcs.md#func-sorttlistt-t-t---ordering-bool-bool) | Sorts a `List` using a comparison function. Parameters specify whether to perform a stable sort and whether to sort in ascending or descending order. |
| [sort\<T>(List\<T>, (T, T) -> Bool, Bool, Bool)](./sort_package_api/sort_package_funcs.md#func-sorttlistt-t-t---bool-bool-bool) | Sorts a `List` using a comparison function. Parameters specify whether to perform a stable sort and whether to sort in ascending or descending order. |
| [sort\<T, K>(List\<T>, (T) -> K, Bool, Bool) where K <: Comparable\<K>](./sort_package_api/sort_package_funcs.md#func-sortt-klistt-t---k-bool-bool-where-k--comparablek) | Sorts a `List` by specified keys (where keys are comparable). Parameters specify whether to perform a stable sort and whether to sort in ascending or descending order. |
| [stableSort\<T>(Array\<T>) where T <: Comparable\<T> <sup>(deprecated)</sup>](./sort_package_api/sort_package_funcs.md#func-stablesorttarrayt-where-t--comparablet-deprecated) | Performs a stable ascending sort on an array. |
| [stableSort\<T>(Array\<T>, (T, T) -> Ordering) <sup>(deprecated)</sup>](./sort_package_api/sort_package_funcs.md#func-stablesorttarrayt-t-t---ordering-deprecated) | Performs a stable ascending sort on an array. |
| [unstableSort\<T>(Array\<T>) where T <: Comparable\<T> <sup>(deprecated)</sup>](./sort_package_api/sort_package_funcs.md#func-unstablesorttarrayt-where-t--comparablet-deprecated) | Performs an unstable ascending sort on an array. |
| [unstableSort\<T>(Array\<T>, (T, T) -> Ordering) <sup>(deprecated)</sup>](./sort_package_api/sort_package_funcs.md#func-unstablesorttarrayt-t-t---ordering-deprecated) | Performs an unstable ascending sort on an array. |

### Interfaces

| Interface Name | Description |
| --------------------------------- | ---------------------------------- |
| [SortByExtension <sup>(deprecated)</sup>](./sort_package_api/sort_package_interfaces.md#interface-sortbyextensiont-deprecated) | This interface serves as an auxiliary interface for sorting-related operations and is empty internally. |
| [SortExtension <sup>(deprecated)</sup>](./sort_package_api/sort_package_interfaces.md#interface-sortextension-deprecated) | This interface serves as an auxiliary interface for sorting-related operations and is empty internally. |