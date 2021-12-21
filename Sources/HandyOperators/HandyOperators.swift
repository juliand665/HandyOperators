infix operator <-: WithPrecedence

precedencegroup WithPrecedence {
	lowerThan: NilCoalescingPrecedence
	higherThan: ComparisonPrecedence
	
	associativity: left
}

/**
Often called `with`, this function allows you to apply extra transformations to something without creating a `var` to mutate.

Especially useful when configuring constants, e.g.:
 ```swift
let dateFormatter = DateFormatter() <- {
	$0.timeStyle = .long
}
```
*/
@inlinable
@discardableResult
public func <- <T>(
	object: T,
	transform: (inout T) throws -> Void
) rethrows -> T {
	var copy = object
	try transform(&copy)
	return copy
}

/**
 Often called `with`, this function allows you to apply extra transformations to something without creating a `var` to mutate.
 
 Especially useful when configuring constants, e.g.:
 ```swift
 let dateFormatter = DateFormatter() <- {
 	$0.timeStyle = .long
 }
 ```
 */
// TODO: just waiting for reasync here
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
@inlinable
@discardableResult
public func <- <T>(
	object: T,
	transform: (inout T) async throws -> Void
) async rethrows -> T {
	var copy = object
	try await transform(&copy)
	return copy
}

// these disfavored nonmutating overloads allow you to use pointfree notation like e.g. `getData() <- handleUpdate`

/**
 Often called `with`, this function allows you to apply extra transformations to something without creating a `var` to mutate.
 
 Especially useful when configuring constants, e.g.:
 ```swift
 let dateFormatter = DateFormatter() <- {
	$0.timeStyle = .long
 }
 ```
 */
@_disfavoredOverload
@discardableResult
public func <- <T>(object: T, use: (T) throws -> Void) rethrows -> T {
	try use(object)
	return object
}

/**
 Often called `with`, this function allows you to apply extra transformations to something without creating a `var` to mutate.
 
 Especially useful when configuring constants, e.g.:
 ```swift
 let dateFormatter = DateFormatter() <- {
	$0.timeStyle = .long
 }
 ```
 */
// TODO: just waiting for reasync here
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
@_disfavoredOverload
@inlinable
@discardableResult
public func <- <T>(object: T, use: (T) async throws -> Void) async rethrows -> T {
	try await use(object)
	return object
}

infix operator ???: NilCoalescingPrecedence

/**
"unwrap-or-error"

Takes an optional, returning its wrapped value if present and throwing the given error otherwise.

The error is wrapped in an `@autoclosure`, so it's not evaluated unless it's actually thrown.
*/
@inlinable
public func ??? <Wrapped>(
	optional: Wrapped?,
	error: @autoclosure () throws -> Error
) throws -> Wrapped {
	try optional ?? { throw try error() }()
}
