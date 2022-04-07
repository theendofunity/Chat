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
    var image: UIImage? = nil
    var downloadUrl: URL? = nil
    
    var representation: [String : Any] {
        var dict: [String : Any] = [
            "created" : sentDate,
            "senderId" : sender.senderId,
            "senderName" : sender.displayName,
        ]
        
        if let downloadUrl = downloadUrl {
            dict["url"] = downloadUrl.absoluteString
        } else {
            dict["content"] = content
        }
        return dict
    }
    
    init(user: MUser, content: String) {
        self.content = content
        sender = user
        sentDate = Date()
        id = nil
    }
    
    init(user: MUser, image: UIImage) {
        sender = user
        sentDate = Date()
        id = nil
        content = ""
        self.image = image
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let date = data["created"] as? Timestamp,
              let id = data["senderId"] as? String,
              let name = data["senderName"] as? String
              //              let content = data["content"] as? String
        else { return nil }
        
        sender = SenderModel(id: id, username: name)
        sentDate = date.dateValue()
        self.id = document.documentID
        
        if let content = data["content"] as? String  {
            self.content = content
        } else if let url = data["url"] as? String {
            self.downloadUrl = URL(string: url)
            self.content = ""
        } else {
            return nil
        }
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
        if let image = image {
            let mediaItem = ImageItem(url: nil, image: nil, placeholderImage: image, size: image.size)
            return .photo(mediaItem)
        }
        return .text(content)
    }
}

extension Message: Comparable {
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}
