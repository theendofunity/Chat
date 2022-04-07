//
//  Completions.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 08.04.2022.
//

import Foundation

typealias VoidCompletion = (Result<Void, Error>) -> Void
typealias ChatCompletion = (Result<Chat, Error>) -> Void
typealias MessagesCompletion = (Result<[Message], Error>) -> Void
typealias MessageCompletion = (Result<Message, Error>) -> Void
typealias UserCompletion = (Result<MUser, Error>) -> Void
typealias UrlCompletion = (Result<URL, Error>) -> Void
