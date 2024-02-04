//
//  File.swift
//  
//
//  Created by 김수아 on 2/4/24.
//

import Foundation
import Combine

public struct Authorization{}

extension Authorization{
    static let _isLoggedIn = PassthroughSubject<Bool, Never>()
    public static var isLoggedIn: AnyPublisher<Bool, Never> { _isLoggedIn.eraseToAnyPublisher() }
}
