//
//  SenderModel.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 03.04.2022.
//

import Foundation
import MessageKit

struct SenderModel: SenderType, Hashable {
    var senderId: String {
        return id
    }
    
    var displayName: String {
        return username
    }
    
    var id: String
    var username: String
}
