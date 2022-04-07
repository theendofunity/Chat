//
//  UIScrollView + Extension.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 08.04.2022.
//

import UIKit

extension UIScrollView {
    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let contentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = contentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
}
