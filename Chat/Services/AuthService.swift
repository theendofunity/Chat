//
//  AuthService.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 21.03.2022.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    
    private let auth = Auth.auth()
    
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void) {
        guard let email = email,
              let password = password
        else { return }
        auth.createUser(withEmail: email, password: password) { result, error in
            guard let result = result else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(result.user))
        }
        
    }
    
    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {
        guard let email = email,
        let password = password else {
            return
        }
        auth.signIn(withEmail: email, password: password) { result, error in
            guard let result = result else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(result.user))
        }
    }
}