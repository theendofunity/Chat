//
//  User.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 16.03.2022.
//

import Foundation

struct User: Hashable, Decodable {
    var username: String
    var avatarStringURL: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter,
              !filter.isEmpty else {
            return true
        }
        let lowercasedFilter = filter.lowercased()
        
        return username.lowercased().contains(lowercasedFilter)
    }
}
