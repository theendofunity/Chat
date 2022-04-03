//
//  FirestoreService.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 22.03.2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class FirestoreService {
    static let shared = FirestoreService()
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    private var waitingChatsRef: CollectionReference? {
        guard let id = currentUser?.id else { return nil }
        let path = ["users", id, "waitingChats"].joined(separator: "/")
        return db.collection(path)
    }
    
    private var activeChatsRef: CollectionReference? {
        guard let id = currentUser?.id else { return nil }
        let path = ["users", id, "activeChats"].joined(separator: "/")
        return db.collection(path)
    }
    
    private var currentUser: MUser?
    
    func saveProfileWith(id: String, email: String, username: String?, avatarImage: UIImage?, description: String?, sex: String?, completion: @escaping ((Result<MUser, Error>) -> Void)) {
        
        guard Validators.isFilled(fields: [username, description, sex]) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        guard let avatarImage = avatarImage else {
            completion(.failure(UserError.photoNotExist))
            return
        }

        guard let username = username,
        let description = description,
        let sex = sex else { return }

        var mUser = MUser(username: username,
                          avatarStringURL: "not exist",
                          id: id,
                          email: email,
                          description: description,
                          sex: sex)
        StorageService.shared.uploadPhoto(image: avatarImage) { [self] result in
            switch result {
                
            case .success(let url):
                mUser.avatarStringURL = url.absoluteString
                self.usersRef.document(mUser.id).setData(mUser.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(mUser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func getUserData(user: User, completion: @escaping ((Result<MUser, Error>) -> Void)) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { document, error in
            guard let document = document, document.exists else {
                completion(.failure(UserError.cantGetUserInfo))
                return
            }
            guard let mUser = MUser(document: document) else {
                completion(.failure(UserError.cantUnwrapUserData))
                return
            }
            self.currentUser = mUser
            completion(.success(mUser))
        }
    }
    
    func createWaitingChat(message: String, receiver: MUser, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUser = currentUser else { return }
        
        let path = ["users", receiver.id, "waitingChats"].joined(separator: "/")
        let collection = db.collection(path)
        let messageRef = collection.document(currentUser.id).collection("messages")
        
        let message = Message(user: currentUser, content: message)
        let chat = Chat(friendUsername: currentUser.username,
                        friendImageString: currentUser.avatarStringURL,
                        lastMessageContent: message.content,
                        friendId: currentUser.id)
        collection.document(currentUser.id).setData(chat.representation) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            messageRef.addDocument(data: message.representation) { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(Void()))
            }
        }
    }
    
    func removeWaitingChat(chat: Chat, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let waitingChatsRef = waitingChatsRef else {
            return
        }
        waitingChatsRef.document(chat.friendId).delete() { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            self.deleteMessages(chat: chat, completion: completion)
        }
    }
    
    func deleteMessages(chat: Chat, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let ref = waitingChatsRef?.document(chat.friendId).collection("messages") else { return }
        
        getWaitingChatMessages(chat: chat) { result in
            switch result {
                
            case .success(let messages):
                for message in messages {
                    guard let documentId = message.id else { return }
                    
                    let messageRef = ref.document(documentId)
                    messageRef.delete() { error in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        completion(.success(Void()))
                    }
                    
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getWaitingChatMessages(chat: Chat, completion: @escaping (Result<[Message], Error>) -> Void) {
        let ref = waitingChatsRef?.document(chat.friendId).collection("messages")
        ref?.getDocuments(completion: { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            var messages: [Message] = []
            guard let snapshot = querySnapshot else { return }
            for document in snapshot.documents {
                guard  let message = Message(document: document) else { return }
                messages.append(message)
            }
            completion(.success(messages))
        })
    }
    
    func changeToActive(chat: Chat, completion: @escaping (Result<Void, Error>) -> Void) {
        getWaitingChatMessages(chat: chat) { result in
            switch result {
            case .success(let messages):
                self.removeWaitingChat(chat: chat) { result in
                    switch result {
                    case .success():
                        self.createActiveChat(chat: chat, messages: messages) { result in
                            switch result {
                            case .success():
                                completion(.success(Void()))
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createActiveChat(chat: Chat, messages: [Message], completion: @escaping (Result<Void, Error>) -> Void) {
        guard let ref = activeChatsRef else { return }
        
        let messageRef = ref.document(chat.friendId).collection("messages")
        
        ref.document(chat.friendId).setData(chat.representation) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            for message in messages {
                messageRef.addDocument(data: message.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    completion(.success(Void()))
                }
            }
        }
    }
}
