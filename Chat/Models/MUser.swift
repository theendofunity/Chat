//
//  User.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 16.03.2022.
//

import Foundation
import FirebaseFirestore

struct MUser: Hashable, Decodable {
    var username: String
    var avatarStringURL: String
    var id: String
    var email: String
    var description: String
    var sex: String
    
    init(username: String, avatarStringURL: String, id: String, email: String, description: String, sex: String) {
        self.username = username
        self.id = id
        self.avatarStringURL = avatarStringURL
        self.email = email
        self.description = description
        self.sex = sex
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else {
            return nil
        }
        guard let username = data["username"] as? String,
              let uid = data["uid"] as? String,
              let avatarStringURL = data["avatarStringURL"] as? String,
              let email = data["email"] as? String,
              let sex = data["sex"] as? String,
              let description = data["description"] as? String
        else {
            return nil
        }
        
        self.username = username
        self.id = uid
        self.avatarStringURL = avatarStringURL
        self.email = email
        self.description = description
        self.sex = sex
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let username = data["username"] as? String,
              let uid = data["uid"] as? String,
              let avatarStringURL = data["avatarStringURL"] as? String,
              let email = data["email"] as? String,
              let sex = data["sex"] as? String,
              let description = data["description"] as? String
        else {
            return nil
        }
        
        self.username = username
        self.id = uid
        self.avatarStringURL = avatarStringURL
        self.email = email
        self.description = description
        self.sex = sex
    }
    
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
