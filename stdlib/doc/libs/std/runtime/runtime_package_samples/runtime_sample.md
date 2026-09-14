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

// 处理器返回 false 表示未处理该信号
func signalHandler1(sig: Int32): Bool {
    println("处理器1执行, 信号: ${sig}, 返回 false")
    return false
}

// 处理器返回 true 表示已处理该信号
func signalHandler2(sig: Int32): Bool {
    println("处理器2执行, 信号: ${sig}, 返回 true")
    return true
}

let signalNumber: Int32 = 3

main() {
    // 重置信号处理器后，注册两个处理器
    resetSignalHandler()
    registerSignalHandler(Signal(signalNumber, "cj"), signalHandler1)
    registerSignalHandler(Signal(signalNumber, "cj"), signalHandler2)

    // 发送信号（信号 3 即 SIGQUIT）
    spawn {
        sendSignal(signalNumber)
    }
    sleep(Duration.second * 1)
    println("end")
    return 0
}
```

可能的运行结果：

```text
25659 E CJNative Handle signal: 3.
处理器1执行, 信号: 3, 返回 false
处理器2执行, 信号: 3, 返回 true
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

// 处理器返回 false 表示未处理该信号
func signalHandler1(sig: Int32): Bool {
    println("处理器1执行, 信号: ${sig}, 返回 false")
    return false
}

// 处理器返回 false 表示未处理该信号
func signalHandler2(sig: Int32): Bool {
    println("处理器2执行, 信号: ${sig}, 返回 false")
    return false
}

let signalNumber: Int32 = 3

main() {
    // 重置信号处理器后，注册两个处理器
    resetSignalHandler()
    registerSignalHandler(Signal(signalNumber, "cj"), signalHandler1)
    registerSignalHandler(Signal(signalNumber, "cj"), signalHandler2)

    // 发送信号（信号 3 即 SIGQUIT）
    spawn {
        sendSignal(signalNumber)
    }
    sleep(Duration.second * 1)
    println("end")
    return 0
}
```

可能的运行结果：

```text
26095 E CJNative Handle signal: 3.
处理器1执行, 信号: 3, 返回 false
处理器2执行, 信号: 3, 返回 false
[8]    26095 quit (core dumped)  ./main
```