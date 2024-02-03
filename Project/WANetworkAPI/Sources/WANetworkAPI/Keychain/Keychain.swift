//
//  Keychain.swift
//  whatsapp
//
//  Created by 김수아 on 2/4/24.
//

import Foundation
import Security

enum Keychain{
    static subscript(_ key: String) -> String?{
        get{
            let query: NSDictionary = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecReturnData: kCFBooleanTrue as Any,
                kSecMatchLimit: kSecMatchLimitOne
            ]
            var dataTypeRef: AnyObject?
            let status = SecItemCopyMatching(query, &dataTypeRef)
            
            if status == errSecSuccess, let data = dataTypeRef as? Data{
                return String(data: data, encoding: .utf8)
            }else{
                return nil
            }
        }
        set{
            let query: NSDictionary = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecValueData: newValue?.data(using: .utf8, allowLossyConversion: false) as Any
            ]
            SecItemDelete(query)
            SecItemAdd(query, nil)
        }
    }
}
