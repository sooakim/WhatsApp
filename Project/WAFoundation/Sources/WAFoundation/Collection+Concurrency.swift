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
        try await withThrowingTaskGroup(of: (Int, R).self, body: { group in
            for (index, element) in self.enumerated() {
                group.addTask {
                    (index, try await operation(element))
                }
            }
            var results = [(Int, R)]()
            for try await result in group{
                results.append(result)
            }
            return results.sorted { lhs, rhs in
                lhs.0 < rhs.0
            }.map{ $0.1 }
        })
    }
}
