//
//  Chat.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 16.03.2022.
//

import Foundation

struct Chat: Hashable, Decodable {
    var friendUsername: String
    var friendImageString: String
    var lastMessageContent: String
    var friendId: String
    
    var representation: [String : Any] {
        let dict: [String : Any] = [
            "friendUsername" : friendUsername,
            "friendImageString" : friendImageString,
            "lastMessage" : lastMessageContent,
            "friendId" : friendId
        ]
        return dict
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: Chat, rhs: Chat) -> Bool {
        return lhs.friendId == rhs.friendId
    }
}
