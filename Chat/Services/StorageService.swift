//
//  StorageService.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 27.03.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class StorageService {
    static let shared = StorageService()
    
    private let storageRef = Storage.storage().reference()
    private var avatarsRef: StorageReference {
        return storageRef.child("avatars/")
    }
    private var currentUserId: String? {
        return Auth.auth().currentUser?.uid
    }
    
    func uploadPhoto(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let currentUserId = currentUserId else {
            return
        }

        guard let scaledImage = image.scaledToSaveUploadSize,
              let imageData = scaledImage.jpegData(compressionQuality: 0.4) else {
            return
        }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        avatarsRef.child(currentUserId).putData(imageData,
                                                metadata: metaData) { storageMetadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let _ = storageMetadata else { return }
            
            self.avatarsRef.child(currentUserId).downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let url = url else { return }
                
                completion(.success(url))
            }
        }
    }
}
