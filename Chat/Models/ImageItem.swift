//
//  ImageItem.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 08.04.2022.
//

import Foundation
import MessageKit

struct ImageItem: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
    
}
