//
//  Chat.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 16.03.2022.
//

import Foundation

struct Chat: Hashable, Decodable {
    var username: String
    var userImageString: String
    var lastMessage: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Chat, rhs: Chat) -> Bool {
        return lhs.id == rhs.id
    }
}
