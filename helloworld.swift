struct Test {}

func hello(_ world: String) -> (Void) -> String {
    func builder() -> String {
        return "Hello, \(world)"
    }
    return builder
}

let obj = hello("Adrian")
let str = obj()

print(str)

