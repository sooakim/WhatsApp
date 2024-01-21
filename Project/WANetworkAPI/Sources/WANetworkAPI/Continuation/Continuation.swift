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
#else
typealias Continuation = UncheckedContinuation<T, Never>
typealias ThrowingContinuation = UncheckedContinuation<T, Error>
#endif
