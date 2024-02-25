//
//  File.swift
//
//
//  Created by 김수아 on 2/25/24.
//

import Foundation

public enum WANetworkError: Error{
    case response(String, 
                  details: String,
                  id: String,
                  requestId: String,
                  statusCode: Int)
}
