//
//  WaitingChatCell.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 16.03.2022.
//

import UIKit

class WaitingChatCell: UICollectionViewCell {
    let userImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WaitingChatCell {
    func setupConstraints() {
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(userImageView)
        
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: topAnchor),
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            userImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension WaitingChatCell: SelfConfiguringCell {
    static var reuseId: String {
        return NSStringFromClass(WaitingChatCell.self)
    }
    
    func configure(with value: MChat) {
        userImageView.image = UIImage(named: value.userImageString)
    }
    
    
}
