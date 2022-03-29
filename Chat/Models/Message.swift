//
//  Message.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 28.03.2022.
//

import Foundation
import FirebaseFirestore

struct Message: Hashable {
    let content: String
    let senderId: String
    let senderUsername: String
    let sentDate: Date
    let messageId: String?
    
    var representation: [String : Any] {
        let dict: [String : Any] = [
            "created" : sentDate,
            "senderId" : senderId,
            "senderName" : senderUsername,
            "content" : content
        ]
        return dict
    }
    
    init(user: MUser, content: String) {
        self.content = content
        senderId = user.id
        senderUsername = user.username
        sentDate = Date()
        messageId = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let date = data["created"] as? Timestamp,
              let id = data["senderId"] as? String,
              let name = data["senderName"] as? String,
              let content = data["content"] as? String else { return nil }
        
        self.content = content
        senderId = id
        senderUsername = name
        sentDate = date.dateValue()
        messageId = document.documentID
    }
}
