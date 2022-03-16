//
//  UIColor+Extension.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 09.03.2022.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        let r, g, b: CGFloat
        r = CGFloat(red) / 255.0
        g = CGFloat(green) / 255.0
        b = CGFloat(blue) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    static var buttonRed: UIColor {
        return #colorLiteral(red: 0.8599731326, green: 0.1256897449, blue: 0.1353026032, alpha: 1)
    }
    
    static var mainWhite: UIColor {
        return #colorLiteral(red: 0.9750193954, green: 0.97865659, blue: 0.9938426614, alpha: 1)
    }
    
    static var buttonBlack: UIColor {
        return #colorLiteral(red: 0.2078431373, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
    }
    
    static var textFieldLightGray: UIColor {
        return #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
    }
    
    static var tabbarTintColor: UIColor {
        return #colorLiteral(red: 0.5568627451, green: 0.3529411765, blue: 0.968627451, alpha: 1)
    }
    
    static var headerGray: UIColor {
        return UIColor(red: 146, green: 146, blue: 146)
    }
}
