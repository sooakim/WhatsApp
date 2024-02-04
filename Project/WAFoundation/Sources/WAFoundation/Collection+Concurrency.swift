//
//  File.swift
//  
//
//  Created by 김수아 on 2/4/24.
//

import Foundation

extension Collection{
    public func asyncMap<R>(
        _ operation: @escaping (Element) async throws -> R
    ) async rethrows -> [R] {
        try await withThrowingTaskGroup(of: R.self, body: { group in
            for element in self {
                group.addTask {
                    try await operation(element)
                }
            }
            var results = [R?]()
            for try await result in group{
                results.append(result)
            }
            return results.compactMap{ $0 }
        })
    }
}
