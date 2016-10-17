import Foundation

#if os(OSX)
    typealias Executable = Process
#else
    typealias Executable = Task
#endif

func shell(_ args: String...) -> Int32 {
    let task = Executable()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

_ = shell("ls")

