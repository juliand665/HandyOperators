infix operator <-: NilCoalescingPrecedence

/**
Often called `with`, this function allows you to apply extra transformations to something without creating a `var` to mutate.

Especially useful when configuring constants, e.g. ```
let dateFormatter = DateFormatter() <- {
	$0.timeStyle = .long
}
```
*/
@discardableResult
public func <- <T>(
	object: T,
	transform: (inout T) throws -> Void
) rethrows -> T {
	var copy = object
	try transform(&copy)
	return copy
}

infix operator ???: NilCoalescingPrecedence

/**
"unwrap-or-error"

Takes an optional, returning its wrapped value if present and throwing the given error otherwise.

The error is wrapped in an `@autoclosure`, so it's not evaluated unless it's actually thrown.
*/
public func ??? <Wrapped>(
	optional: Wrapped?,
	error: @autoclosure () throws -> Error
) throws -> Wrapped {
	try optional ?? { throw try error() }()
}
