//
//  Continuation.swift
//
//
//  Created by 김수아 on 1/21/24.
//

import Foundation

#if DEBUG
typealias Continuation<T> = CheckedContinuation<T, Never>
typealias ThrowingContinuation<T> = CheckedContinuation<T, Error>

@inlinable public func withThrowingContinuation<T>(function: String = #function, _ body: (CheckedContinuation<T, Error>) -> Void) async throws -> T{
    try await withCheckedThrowingContinuation(body)
}

@inlinable public func withContinuation<T>(function: String = #function, _ body: (CheckedContinuation<T, Never>) -> Void) async -> T{
    await withCheckedContinuation(body)
}
#else
typealias Continuation = UncheckedContinuation<T, Never>
typealias ThrowingContinuation = UncheckedContinuation<T, Error>

@inlinable public func withThrowingContinuation<T>(function: String = #function, _ body: (CheckedContinuation<T, Error>) -> Void) async throws -> T{
    try await withUncheckedThrowingContinuation(body)
}

@inlinable public func withContinuation<T>(function: String = #function, _ body: (CheckedContinuation<T, Never>) -> Void) async -> T{
    await withUncheckedContinuation(body)
}
#endif
