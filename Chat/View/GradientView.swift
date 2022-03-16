//
//  GradientView.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 16.03.2022.
//

import UIKit

class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()
    
    init(from: Point, to: Point, startColor: UIColor?, endColor: UIColor?) {
        self.init()
        setupGradient(from: from, to: to, startColor: startColor, endColor: endColor)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func setupGradient(from: Point, to: Point, startColor: UIColor?, endColor: UIColor?) {
        backgroundColor = .red
        layer.addSublayer(gradientLayer)
        setupColors(startColor: startColor, endColor: endColor)
        gradientLayer.startPoint = from.point
        gradientLayer.endPoint = to.point
    }
    
    func setupColors(startColor: UIColor?, endColor: UIColor?) {
        guard let startColor = startColor,
              let endColor = endColor else {
            return
        }
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
