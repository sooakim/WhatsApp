//
//  File.swift
//
//
//  Created by 김수아 on 2/5/24.
//

import Foundation
import WAFoundation

public enum UserDefault{
    internal(set) public static var user: NetworkAPI.User.Login.Response?{
        get{
            guard let value = UserDefaults.standard.value(forKey: "user") as? Data else{ return nil }
            return try? JSONDecoder.shared.decode(NetworkAPI.User.Login.Response.self, from: value)
        }
        set{
            UserDefaults.standard.setValue(newValue.compactMap{ (value) -> Data? in
                try? JSONEncoder.shared.encode(value)
            }, forKey: "user")
        }
    }
}
