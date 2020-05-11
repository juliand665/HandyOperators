# HandyOperators

Provides some general-purpose operators for shorter & more expressive code.

## `<-` ("with")

Applies a closure to a value, returning the transformed copy.

```swift
final class Client {
    // with HandyOperators
    let jsonDecoder1 = JSONDecoder() <- {
        $0.dateDecodingStrategy = .iso8601
    }
    
    // without HandyOperators
    let jsonDecoder2: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }()
}
```

Also useful for easily applying mutating functions to copies:

```swift
extension Array {
    // with HandyOperators
    func appending1(_ element: Element) -> Self {
        self <- { $0.append(element) }
    }
    
    // without HandyOperators
    func appending2(_ element: Element) -> Self {
        var copy = self
        copy.append(element)
        return copy
    }
}
```

## `???` (unwrap or throw)

Takes an optional and an error (autoclosure, so it's lazy) and returns the unwrapped optional or throws if `nil`.

```swift
// with HandyOperators
func doSomething1(with optional: String?) throws {
    print(try optional ??? MissingValueError())
}

// without HandyOperators
func doSomething2(with optional: String?) throws {
    guard let value = optional else { throw MissingValueError() }
    print(value)
}
```

