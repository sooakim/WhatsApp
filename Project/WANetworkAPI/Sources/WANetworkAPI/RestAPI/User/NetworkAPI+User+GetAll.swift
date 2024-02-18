//
//  File.swift
//
//
//  Created by 김수아 on 2/5/24.
//

import Foundation
import MetaCodable

extension NetworkAPI.User{
    public enum GetAll {}
}

extension NetworkAPI.User.GetAll{
    @Codable
    @MemberInit
    public struct Request{
        @CodedAt("page")
        @Default(0)
        public let page: Int
        
        @CodedAt("per_page")
        @Default(60)
        public let perPage: Int
        
        @CodedAt("in_term")
        public let inTerm: String?
        
        @CodedAt("not_in_term")
        public let notInTerm: String?
        
        @CodedAt("in_channel")
        public let inChannel: String?
        
        @CodedAt("not_in_channel")
        public let notInChannel: String?
        
        @CodedAt("in_group")
        public let inGroup: String?
        
        @CodedAt("group_constrained")
        public let groupConstrained: Bool?
        
        @CodedAt("without_team")
        public let withoutTeam: Bool?
        
        @CodedAt("active")
        public let active: Bool?
        
        @CodedAt("inactive")
        public let inactive: Bool?
        
        @CodedAt("role")
        public let role: String?
        
        @CodedAt("sort")
        public let sort: String?
        
        @CodedAt("roles")
        public let roles: String?
        
        @CodedAt("channel_roles")
        public let channelRoles: String?
        
        @CodedAt("team_roles")
        public let teamRoles: String?
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
        public let notifyProps: NotifyProps?
        
        @CodedAt("props")
        public let props: [String: String]?
        
        @CodedAt("last_password_update")
        public let lastPasswordUpdate: Int?
        
        @CodedAt("last_picture_update")
        public let lastPictureUpdate: Int?
        
        @CodedAt("failed_attempts")
        public let failedAttempts: Int?
        
        @CodedAt("mfa_active")
        public let mfaActive: Bool?
        
        @CodedAt("timezone")
        public let timezone: Timezone
        
        @CodedAt("terms_of_service_id")
        public let termsOfServiceId: String?
        
        @CodedAt("terms_of_service_create_at")
        public let termsOfServiceCreateAt: Int?
    }
}

extension NetworkAPI.User.GetAll.Response{
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
    public struct Timezone{
        @CodedAt("useAutomaticTimezone")
        public let useAutomaticTimezone: String
        
        @CodedAt("manualTimezone")
        public let manualTimezone: String
        
        @CodedAt("automaticTimezone")
        public let automaticTimezone: String
    }
}
