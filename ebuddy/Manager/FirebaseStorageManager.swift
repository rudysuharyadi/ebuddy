//
//  FirebaseStorageManager.swift
//  ebuddy
//
//  Created by Rudy Suharyadi on 11/12/24.
//

import Foundation
import FirebaseStorage
import SwiftUI

class FirebaseStorageManager {
    private let storage = Storage.storage()

    @MainActor
    func uploadImage(uid: String, imageData: Data, completion: @escaping (Result<URL, Error>) -> Void) {
        var backgroundTask: UIBackgroundTaskIdentifier = .invalid
        backgroundTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            UIApplication.shared.endBackgroundTask(backgroundTask)
        })
        
        let storageRef = storage.reference()
        let imageRef = storageRef.child("images/\(uid).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let uploadTask = imageRef.putData(imageData, metadata: metadata)
        
        uploadTask.observe(.success) { snapshot in
            imageRef.downloadURL { url, error in
                defer {
                    UIApplication.shared.endBackgroundTask(backgroundTask)
                }
                
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
            defer {
                UIApplication.shared.endBackgroundTask(backgroundTask)
            }
            
            guard let error = snapshot.error else { return }
            completion(.failure(error))
        }
    }
}
