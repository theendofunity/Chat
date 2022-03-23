//
//  UserError.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 22.03.2022.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExist
    case cantGetUserInfo
    case cantUnwrapUserData
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return "Need to fill all fields"
        case .photoNotExist:
            return "Photo not exist"
        case .cantGetUserInfo:
            return "Can't get user info from firebase"
        case .cantUnwrapUserData:
            return "Can't unwrap user info"
        }
    }
}
