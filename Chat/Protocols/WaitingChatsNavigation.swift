//
//  WaitingChatsNavigation.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 30.03.2022.
//

import Foundation

protocol WaitingChatsNavigation: AnyObject {
    func removeWaitingChat(chat: Chat)
    func moveToActive(chat: Chat )
}
