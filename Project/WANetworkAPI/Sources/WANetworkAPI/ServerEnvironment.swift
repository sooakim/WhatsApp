//
//  File.swift
//  
//
//  Created by 김수아 on 2/18/24.
//

import Foundation

public enum ServerEnvironment{
    public static let baseHttpURL = URL(string: "http://175.106.97.173:8065")!
    public static let baseSocketURL = URL(string: "ws://175.106.97.173:8065/api/v4/websocket")!
}
