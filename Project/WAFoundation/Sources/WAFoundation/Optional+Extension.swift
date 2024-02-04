//
//  File.swift
//
//
//  Created by 김수아 on 2/5/24.
//

import Foundation

extension Optional{
    public func map<R>(_ closure: (Wrapped) throws -> R) rethrows -> Optional<R>{
        switch self{
        case let .some(wrapped):
            return try closure(wrapped)
        case .none:
            return nil
        }
    }
    
    public func compactMap<R>(_ closure: (Wrapped) throws -> R?) rethrows -> Optional<R>{
        switch self{
        case let .some(wrapped):
            return try closure(wrapped)
        case .none:
            return nil
        }
    }
}

extension Optional{
    public func map<R>(_ closure: (Wrapped) async throws -> R) async rethrows -> Optional<R>{
        switch self{
        case let .some(wrapped):
            return try await closure(wrapped)
        case .none:
            return nil
        }
    }
    
    public func compactMap<R>(_ closure: (Wrapped) async throws -> R?) async rethrows -> Optional<R>{
        switch self{
        case let .some(wrapped):
            return try await closure(wrapped)
        case .none:
            return nil
        }
    }
}
