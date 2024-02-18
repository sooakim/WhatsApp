//
//  Providable.swift
//
//
//  Created by 김수아 on 1/21/24.
//

import Foundation
import Moya

public protocol Providable{
    
}

private var moyaProviderKey: Void?

private let responseQueue = DispatchQueue(
    label: "io.github.sooakim.whatsapp.networkapi.response",
    qos: .userInteractive,
    attributes: [.concurrent],
    autoreleaseFrequency: .workItem,
    target: nil
)

extension Providable where Self: TargetType{
    static var moyaProvider: MoyaProvider<Self>{
        get{
            var moyaProvider = objc_getAssociatedObject(self, &moyaProviderKey) as? MoyaProvider<Self>
            if let moyaProvider{
                return moyaProvider
            }
            let plugins: [PluginType]
#if DEBUG
            plugins = [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
#endif
            
            moyaProvider = MoyaProvider<Self>(requestClosure: { endpoint, closure in
                MoyaProvider<Self>.defaultRequestMapping(for: endpoint, closure: { result in
                    switch result{
                    case var .success(urlRequest):
                        urlRequest.headers = [
                            "Authorization": "Bearer \(Keychain["token"] ?? "")"
                        ]
                        closure(.success(urlRequest))
                    default:
                        closure(result)
                    }
                })
            }, plugins: plugins)
            objc_setAssociatedObject(self, &moyaProviderKey, moyaProvider, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return moyaProvider!
        }
    }
    
    public static func request<Response: Decodable>(_ targetType: Self) async throws -> Response{
        let cancellable = MoyaCancellableWrapper<ThrowingContinuation>{ continuation in
            Self.moyaProvider.request(targetType, callbackQueue: responseQueue, progress: .none){ result in
                do{
                    switch result{
                    case let .success(response):
                        if (200..<300 ~= response.statusCode) == false{
                            if response.statusCode == 401{
                                Keychain["token"] = nil
                                UserDefault.user = nil
                                Authorization._isLoggedIn.send(false)
                            }
                        }else if let token = response.response?.headers["Token"]{
                            Keychain["token"] = token
                            Authorization._isLoggedIn.send(true)
                        }
                        
                        let jsonData = response.data
                        let decoded = try JSONDecoder.shared.decode(Response.self, from: jsonData)
                        if let decoded = decoded as? NetworkAPI.User.Login.Response{
                            UserDefault.user = decoded
                        }
                        continuation.resume(returning: decoded)
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                }catch{
                    continuation.resume(throwing: error)
                }
            }
        }
        
        return try await withTaskCancellationHandler {
            try await withThrowingContinuation{ continuation in
                cancellable.resume(argument: continuation)
            }
        } onCancel: {
            cancellable.cancel()
        }
    }
}
