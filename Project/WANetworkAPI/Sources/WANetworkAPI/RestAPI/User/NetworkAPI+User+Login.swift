//
//  File.swift
//
//
//  Created by 김수아 on 2/3/24.
//

import Foundation
import MetaCodable

public extension NetworkAPI.User{
    enum Login {}
}

extension NetworkAPI.User.Login{
    @Codable
    @MemberInit
    public struct Request{
        @CodedAt("id")
        public let id: String?
        
        @CodedAt("login_id")
        public let loginId: String
        
        @CodedAt("token")
        public let token: String?
        
        @CodedAt("device_id")
        public let deviceId: String?
        
        @CodedAt("ldap_only")
        public let ldapOnly: Bool?
        
        @CodedAt("password")
        public let password: String
    }
    
    @Codable
    @MemberInit
    public struct Response{
        @CodedAt("id")
        public let id: String
        
        @CodedAt("create_at")
        public let createAt: Int
        
        @CodedAt("update_at")
        public let updateAt: Int
        
        @CodedAt("delete_at")
        public let deleteAt: Int
        
        @CodedAt("username")
        public let username: String
        
        @CodedAt("first_name")
        public let firstName: String
        
        @CodedAt("last_name")
        public let lastName: String
        
        @CodedAt("nickname")
        public let nickname: String
        
        @CodedAt("email")
        public let email: String
        
        @CodedAt("email_verified")
        public let emailVerified: Bool?
        
        @CodedAt("auth_service")
        public let authService: String
        
        @CodedAt("roles")
        public let roles: String
        
        @CodedAt("locale")
        public let locale: String
        
        @CodedAt("notify_props")
        public let notifyProps: NotifyProps
        
        @CodedAt("props")
        public let props: Props?
        
        @CodedAt("last_password_update")
        public let last_password_update: Int
        
        @CodedAt("last_picture_update")
        public let last_picture_update: Int?
        
        @CodedAt("failed_attempts")
        public let failed_attempts: Int?
        
        @CodedAt("mfa_active")
        public let mfa_active: Bool?
        
        @CodedAt("timezone")
        public let timezone: Timezone
        
        @CodedAt("terms_of_service_id")
        public let terms_of_service_id: String?
        
        @CodedAt("terms_of_service_create_at")
        public let terms_of_service_create_at: Int?
        
    }
}

extension NetworkAPI.User.Login.Response{
    @Codable
    @MemberInit
    public struct NotifyProps{
        @CodedAt("email")
        public let email: String
        @CodedAt("push")
        public let push: String
        @CodedAt("desktop")
        public let desktop: String
        @CodedAt("desktop_sound")
        public let desktopSound: String
        @CodedAt("mention_keys")
        public let mentionKeys: String
        @CodedAt("channel")
        public let channel: String
        @CodedAt("first_name")
        public let firstName: String
    }
    
    @Codable
    @MemberInit
    public struct Props{
        
    }
    
    @Codable
    @MemberInit
    public struct Timezone{
        @CodedAt("useAutomaticTimezone")
        public let useAutomaticTimezone: String
        
        @CodedAt("manualTimezone")
        public let manualTimezone: String
        
        @CodedAt("automaticTimezone")
        public let automaticTimezone: String
    }
}
