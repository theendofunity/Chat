//
//  FirestoreService.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 22.03.2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirestoreService {
    static let shared = FirestoreService()
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    func saveProfileWith(id: String, email: String, username: String?, avatarImageString: String?, description: String?, sex: String?, completion: @escaping ((Result<MUser, Error>) -> Void)) {
        
        guard Validators.isFilled(fields: [username, description, sex]) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        guard let username = username,
        let description = description,
        let sex = sex
        else {
            return
        }

        let mUser = MUser(username: username,
                          avatarStringURL: avatarImageString ?? "not exist",
                          id: id,
                          email: email,
                          description: description,
                          sex: sex)
        usersRef.document(mUser.id).setData(mUser.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(mUser))
            }
        }

    }
}
