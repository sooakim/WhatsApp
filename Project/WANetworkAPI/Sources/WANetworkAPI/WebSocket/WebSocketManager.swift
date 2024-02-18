//
//  File.swift
//
//
//  Created by 김수아 on 2/11/24.
//

import Foundation

public final class WebSocketManager: NSObject{
    public private(set) var isConnected: Bool = false
    
    deinit{
        disconnect()
    }
    
    public func connect() {
        let request = URLRequest(url: Self.url)
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: .socketSessionQueue)
        let webSocket = session.webSocketTask(with: request)
        self.webSocket = webSocket

        webSocket.resume()
    }
    
    public func connectIfNeeded(){
        guard webSocket == nil else{ return }
        connect()
    }
    
    public func disconnect(){
        guard let webSocket else{ return }
        self.webSocket = nil
        webSocket.cancel(with: .goingAway, reason: nil)
    }
    
    public func send(with message: Message) async throws {
        connectIfNeeded()
        
        guard let webSocket else{ return }
        return try await webSocket.send(message.convert())
    }
    
    public func sendPing() async throws {
        connectIfNeeded()
        
        guard let webSocket else{ return }
        return try await withThrowingContinuation{ continuation in
            webSocket.sendPing{ error in
                if let error{
                    continuation.resume(throwing: error)
                }else{
                    continuation.resume(returning: ())
                }
            }
        }
    }
    
    public func receiveStream() -> AsyncThrowingStream<Message, Error>?{
        connectIfNeeded()
        
        guard let webSocket else{ return nil }
        return AsyncThrowingStream(Message.self, bufferingPolicy: .bufferingNewest(1)) { [weak weakWebSocket = webSocket] continuation in
            let task = Task(priority: .high) { [weak weakWebSocket = weakWebSocket] in
                while !Task.isCancelled, let webSocket = weakWebSocket{
                    do{
                        guard let convertedMessage = (try await webSocket.receive()).convert() else{ continue }
                        continuation.yield(with: .success(convertedMessage))
                    }catch{
                        continuation.yield(with: .failure(error))
                    }
                }
            }
            continuation.onTermination = { _ in
                guard !task.isCancelled else{ return }
                task.cancel()
            }
        }
    }
    
    public func receive() async throws -> Message?{
        connectIfNeeded()
        
        guard let webSocket else{ return nil }
        return (try await webSocket.receive()).convert()
    }
    
    // MARK: - Private
    private var webSocket: URLSessionWebSocketTask?
}

extension WebSocketManager: URLSessionWebSocketDelegate{
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        isConnected = true
    }
    
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        isConnected = false
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print(error)
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didReceiveInformationalResponse response: HTTPURLResponse) {
        print(response)
    }
}

public extension WebSocketManager{
    static let shared = WebSocketManager()
    
    enum Message{
        case data(Data)
        case string(String)
    }
}

private extension WebSocketManager.Message{
    func convert() -> URLSessionWebSocketTask.Message{
        switch self{
        case let .data(data):
                .data(data)
        case let .string(string):
                .string(string)
        }
    }
}

private extension URLSessionWebSocketTask.Message{
    func convert() -> WebSocketManager.Message?{
        switch self{
        case let .data(data):
                .data(data)
        case let .string(string):
                .string(string)
        @unknown default:
            nil
        }
    }
}

private extension WebSocketManager{
    static let url = ServerEnvironment.baseSocketURL
}

private extension OperationQueue{
    static let socketSessionQueue = OperationQueue()
}
