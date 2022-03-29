//
//  Chat.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 16.03.2022.
//

import Foundation
import FirebaseFirestore

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
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let username = data["friendUsername"] as? String,
              let imageString = data["friendImageString"] as? String,
              let message = data["lastMessage"] as? String,
              let id = data["friendId"] as? String else {
            return nil
        }
        self.friendUsername = username
        self.friendImageString = imageString
        self.lastMessageContent = message
        self.friendId = id
    }
    
    init(friendUsername: String,
          friendImageString: String,
          lastMessageContent: String,
         friendId: String) {
        self.friendUsername = friendUsername
        self.friendImageString = friendImageString
        self.lastMessageContent = lastMessageContent
        self.friendId = friendId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: Chat, rhs: Chat) -> Bool {
        return lhs.friendId == rhs.friendId
    }
}
