//
//  OneLineTextField.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 09.03.2022.
//

import UIKit

class OneLineTextField: UITextField {

    convenience init(font: UIFont? = .avenir20) {
        self.init()
        
        self.font = font
        self.borderStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomView.backgroundColor = .textFieldLightGray
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 1),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 1)
        ])


    }
}
