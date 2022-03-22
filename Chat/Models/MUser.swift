//
//  User.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 16.03.2022.
//

import Foundation

struct MUser: Hashable, Decodable {
    var username: String
    var avatarStringURL: String
    var id: String
    var email: String
    var description: String
    var sex: String
    
    var representation: [String : Any] {
        let rep: [String : Any] = [
            "username" : username,
            "avatarStringURL" : avatarStringURL,
            "uid" : id,
            "email" : email,
            "description" : description,
            "sex" : sex
        ]
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
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
