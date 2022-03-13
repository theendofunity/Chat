//
//  AddPhotoView.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 14.03.2022.
//

import UIKit

class AddPhotoView: UIView {
    var circleImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Person"), contentMode: .scaleAspectFill)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "add"), for: .normal)
        button.tintColor = .buttonBlack
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(circleImageView)
        self.addSubview(addButton)
        
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleImageView.layer.masksToBounds = true
        circleImageView.layer.cornerRadius = circleImageView.frame.width / 2
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            circleImageView.topAnchor.constraint(equalTo: self.topAnchor),
            circleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            circleImageView.widthAnchor.constraint(equalToConstant: 100),
            circleImageView.heightAnchor.constraint(equalToConstant: 100),
            
            addButton.leadingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: 16),
            addButton.widthAnchor.constraint(equalToConstant: 30),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.centerYAnchor.constraint(equalTo: circleImageView.centerYAnchor),
            
            bottomAnchor.constraint(equalTo: circleImageView.bottomAnchor),
            trailingAnchor.constraint(equalTo: addButton.trailingAnchor),
        ])
    }
}
