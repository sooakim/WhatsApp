//
//  Cancellable+Moya.swift
//
//
//  Created by 김수아 on 1/21/24.
//

import Foundation
import Moya

final class MoyaCancellableWrapper<Argument>{
    private let builder: ((Argument) -> Cancellable)
    private var cancellable: Cancellable?
    
    init(builder: @escaping ((Argument) -> Cancellable)){
        self.builder = builder
    }
    
    func resume(argument: Argument){
        cancellable = builder(argument)
    }
    
    func cancel(){
        guard let cancellable, !cancellable.isCancelled else{ return }
        cancellable.cancel()
    }
}
