//
//  SelfConfiguringCell.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 16.03.2022.
//

import Foundation

protocol SelfConfiguringCell: AnyObject {
    static var reuseId: String { get }
    func configure(with value: MChat)
}
