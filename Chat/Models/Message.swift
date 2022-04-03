//
//  Message.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 28.03.2022.
//

import Foundation
import FirebaseFirestore
import MessageKit

struct Message: Hashable {
    let content: String
    let sender: SenderType
    let sentDate: Date
    let id: String?
    
    var representation: [String : Any] {
        let dict: [String : Any] = [
            "created" : sentDate,
            "senderId" : sender.senderId,
            "senderName" : sender.displayName,
            "content" : content
        ]
        return dict
    }
    
    init(user: MUser, content: String) {
        self.content = content
        sender = user
        sentDate = Date()
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let date = data["created"] as? Timestamp,
              let id = data["senderId"] as? String,
              let name = data["senderName"] as? String,
              let content = data["content"] as? String else { return nil }
        
        self.content = content
        sender = SenderModel(id: id, username: name)
        sentDate = date.dateValue()
        self.id = document.documentID
    }
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.messageId == rhs.messageId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
}

extension Message: MessageType {
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    var kind: MessageKind {
        return .text(content)
    }
    
    
}
