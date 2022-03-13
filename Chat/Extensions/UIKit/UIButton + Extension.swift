//
//  UIButton+Extension.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 09.03.2022.
//

import UIKit

extension UIButton {
    convenience init(title: String,
                     titleColor: UIColor,
                     backgroundColor: UIColor,
                     font: UIFont? = .avenir20,
                     isShadow: Bool,
                     cornerRadius: CGFloat = 4) {
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
    
    func gooleButton() {
//        imageView?.image = UIImage(named: "googleLogo")
        let logo = UIImageView(image: UIImage(named: "googleLogo"), contentMode: .scaleAspectFit)
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(logo)
        logo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        logo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
