# Type Alias

## type MeasurementUnitTable

```cangjie
type MeasurementUnitTable = Array<(Float64, String)>
```

Function: Serves as an alias for the "boundary-unit" pair array used in the unit conversion table of performance test results in [Measurement](unittest_package_interfaces.md#interface-measurement).

The performance test result values to be displayed are calculated from this table based on boundaries during normalization.  
For example, for time units, it could follow `[(1.0, "ns"), (1_000.0, "us"), (1_000_000.0, "ms"), (1_000_000_000.0, "s"), ...]`.