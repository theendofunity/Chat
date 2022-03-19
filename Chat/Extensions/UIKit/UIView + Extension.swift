//
//  UIView + Extension.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 19.03.2022.
//

import UIKit

extension UIView {
    func applyGradient(cornerRadius: CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: .systemPurple, endColor: .systemBlue)
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
