//
//  UIImage + Extension.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 27.03.2022.
//

import UIKit

extension UIImage {
    var scaledToSaveUploadSize: UIImage? {
        let maxLength: CGFloat = 480
        
        let largerSide: CGFloat = max(size.height, size.width)
        let ratioScale = largerSide > maxLength ? largerSide / maxLength : 1
        let newImageSize = CGSize(width: size.width / ratioScale, height: size.height / ratioScale)
        
        return image(scaledTo: newImageSize)
    }
    
    func image(scaledTo size: CGSize) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(in: CGRect(origin: .zero, size: size))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
