//
//  Validators.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 21.03.2022.
//

import Foundation

class Validators {
    static func isFilled(email: String?, password: String?, confirmPassword: String?) -> Bool {
        guard let email = email,
              let password = password,
              let confirmPassword = confirmPassword,
              !email.isEmpty,
              !password.isEmpty,
              !confirmPassword.isEmpty
        else {
            return false
        }
        return true
    }
    
    static func isValidEmail(email: String?) -> Bool {
        guard let email = email else {
            return false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func equalPasswords(password: String?, confirmPassword: String?) -> Bool {
        guard let password = password,
              let confirmPassword = confirmPassword else {
                  return false
              }
        return password == confirmPassword
    }
    
    static func isFilled(email: String?, password: String?) -> Bool {
        guard let email = email,
              let password = password,
              !email.isEmpty,
              !password.isEmpty
        else {
            return false
        }
        return true
    }
    
    static func isFilled(fields: [String?]) -> Bool {
        for field in fields {
            guard let field = field,
                  !field.isEmpty else {
                      return false
                  }
        }
        return true
    }
}
