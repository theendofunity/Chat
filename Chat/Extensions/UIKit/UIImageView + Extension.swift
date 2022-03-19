//
//  UIImage + Extension.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 09.03.2022.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage?, contentMode: ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
    
    func setupColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
