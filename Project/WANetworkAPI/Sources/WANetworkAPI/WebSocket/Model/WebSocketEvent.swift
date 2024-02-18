//
//  File.swift
//  
//
//  Created by 김수아 on 2/11/24.
//

import Foundation

public enum WebSocketEvent: String, Decodable {
    case addedToTeam = "added_to_team"
    case authenticationChallenge = "authentication_challenge"
    case channelConverted = "channel_converted"
    case channelCreated = "channel_created"
    case channelDeleted = "channel_deleted"
    case channelMemberUpdated = "channel_member_updated"
    case channelUpdated = "channel_updated"
    case channelViewed = "channel_viewed"
    case configChanged = "config_changed"
    case deleteTeam = "delete_team"
    case directAdded = "direct_added"
    case emojiAdded = "emoji_added"
    case ephemeralMessage = "ephemeral_message"
    case groupAdded = "group_added"
    case hello
    case leaveTeam = "leave_team"
    case licenseChanged = "license_changed"
    case memberroleUpdated = "memberrole_updated"
    case newUser = "new_user"
    case pluginDisabled = "plugin_disabled"
    case pluginEnabled = "plugin_enabled"
    case pluginStatusesChanged = "plugin_statuses_changed"
    case postDeleted = "post_deleted"
    case postEdited = "post_edited"
    case postUnread = "post_unread"
    case posted
    case preferenceChanged = "preference_changed"
    case preferencesChanged = "preferences_changed"
    case preferencesDeleted = "preferences_deleted"
    case reactionAdded = "reaction_added"
    case reactionRemoved = "reaction_removed"
    case response
    case roleUpdated = "role_updated"
    case statusChange = "status_change"
    case typing
    case updateTeam = "update_team"
    case userAdded = "user_added"
    case userRemoved = "user_removed"
    case userRoleUpdated = "user_role_updated"
    case userUpdated = "user_updated"
    case dialogOpened = "dialog_opened"
    case threadUpdated = "thread_updated"
    case threadFollowChanged = "thread_follow_changed"
    case threadReadChanged = "thread_read_changed"
}
