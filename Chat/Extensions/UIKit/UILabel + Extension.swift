//
//  UILabel + Extension.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 09.03.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont? = .avenir20) {
        self.init()
        
        self.text = text
        self.font = font
    }
}
