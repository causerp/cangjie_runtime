# Usage of Annotations

Retrieve annotation values on an instance through reflection.

Code example:
<!-- verify -->

```cangjie
import std.reflect.*

main() {
    let ti = TypeInfo.of(Test())
    let annotation = ti.findAnnotation<A>()
    if (let Some(a) <- annotation) {
        println(a.name)
    }
}

@A["Annotation"]
public class Test {}

@Annotation
public class A {
    const A(let name: String) {}
}
```

Execution result:

```text
Annotation
```