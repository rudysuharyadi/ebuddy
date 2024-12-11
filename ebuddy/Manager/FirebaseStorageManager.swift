//
//  FirebaseStorageManager.swift
//  ebuddy
//
//  Created by Rudy Suharyadi on 11/12/24.
//

import Foundation
import FirebaseStorage

class FirebaseStorageManager {
    private let storage = Storage.storage()
    
    func uploadImage(uid: String, imageData: Data, completion: @escaping (Result<URL, Error>) -> Void) {
        let storageRef = storage.reference()
        let imageRef = storageRef.child("images/\(uid).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let uploadTask = imageRef.putData(imageData, metadata: metadata)
        
        uploadTask.observe(.success) { snapshot in
            imageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let downloadURL = url {
                    completion(.success(downloadURL))
                }
            }
        }
        
        uploadTask.observe(.failure) { snapshot in
            guard let error = snapshot.error else { return }
            completion(.failure(error))
        }
    }
}
