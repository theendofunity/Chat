//
//  AuthError.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 21.03.2022.
//

import Foundation

enum AuthError {
    case notFilled
    case incorrectEmail
    case incorrectPassword
    case passwordsMismatch
    case serverError
    case unknown
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return "Fill all fields"
        case .incorrectEmail:
            return "Incorrect email"
        case .incorrectPassword:
            return "Incorrect password"
        case .passwordsMismatch:
            return "Passwords not equal"
        case .serverError:
            return "Error from server"
        case .unknown:
            return "Unknown error"
        }
    }
}
