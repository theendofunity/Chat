//
//  ListenerService.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 28.03.2022.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ListenerService {
    static let shared = ListenerService()
    
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    private var currentUserId: String? {
        Auth.auth().currentUser?.uid
    }
    
    func usersObserve(users: [MUser], completion: @escaping (Result<[MUser], Error>) -> Void) -> ListenerRegistration? {
        var users = users
        
        let usersListener = usersRef.addSnapshotListener { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snapshot = querySnapshot else {
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                guard let mUser = MUser(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !users.contains(mUser),
                          let id = self.currentUserId,
                          id != mUser.id else { return }
                        users.append(mUser)
                case .modified:
                    guard let index = users.firstIndex(of: mUser) else { return }
                    users[index] = mUser
                case .removed:
                    guard let index = users.firstIndex(of: mUser) else { return }
                    users.remove(at: index)
                }
            }
            completion(.success(users))
        }
        return usersListener
    }
}
