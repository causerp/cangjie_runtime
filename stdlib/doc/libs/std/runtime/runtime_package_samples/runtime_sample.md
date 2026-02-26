# Signal 示例

## Signal 处理回调后，不处理信号默认行为

示例：

<!-- run -->
```cangjie
import std.env.*
import std.runtime.*

foreign func CJ_MCC_SignalKill(pid: Int32, sig: Int32): Unit

func sendSignal(sig: Int32): Unit {
    unsafe { CJ_MCC_SignalKill(Int32(getProcessId()), sig) }
    sleep(Duration.second)
}

func func_1(sig: Int32) {
    println("func_1_start_${sig}")
    return false
}

func func_2(sig: Int32) {
    println("func_2_start_${sig}")
    return true
}

let signal: Int32 = 3

main() {
    resetSignalHandler()
    registerSignalHandler(Signal(signal, "cj"), func_1)
    registerSignalHandler(Signal(signal, "cj"), func_2)
    spawn {
        sendSignal(signal) // 模拟发送信号
    }
    sleep(Duration.second * 1)
    println("end")
    return 0
}
```

可能的运行结果：

```text
81632 E CJNatvie Handle signal: 3.
func_1_start_3
func_2_start_3
end
```

## Signal 处理回调后，处理信号默认行为

示例：

<!-- run -->
```cangjie
import std.env.*
import std.runtime.*

foreign func CJ_MCC_SignalKill(pid: Int32, sig: Int32): Unit

func sendSignal(sig: Int32): Unit {
    unsafe { CJ_MCC_SignalKill(Int32(getProcessId()), sig) }
    sleep(Duration.second)
}

func func_1(sig: Int32) {
    println("func_1_start_${sig}")
    return false
}

func func_2(sig: Int32) {
    println("func_2_start_${sig}")
    return false
}

let signal: Int32 = 3

main() {
    resetSignalHandler()
    registerSignalHandler(Signal(signal, "cj"), func_1)
    registerSignalHandler(Signal(signal, "cj"), func_2)
    spawn {
        sendSignal(signal) // 模拟信号发送
    }
    sleep(Duration.second * 1)
    println("end")
    return 0
}
```

可能的运行结果：

```text
82934 E CJNative Handle signal: 3.
func_1_start_3
func_2_start_3
[8]    82934 quit (core dumped)  ./main
```