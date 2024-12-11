//
//  Untitled.swift
//  ebuddy
//
//  Created by Rudy Suharyadi on 11/12/24.
//

import Foundation
import Observation
import PhotosUI
import SwiftUI

@Observable class PhotoUploadVM {
    var selectedPhotos: [PhotosPickerItem] = []
    var images: [UIImage] = []
    var errorMessage: String?
    var uploadProgress: Double = 0.0
    var isUploading: Bool = false
    
    private var firebaseStorageManager = FirebaseStorageManager()
    private var firestoreManager = FirestoreManager()
    
    @MainActor
    func loadSelectedPhotos(selectedPhotos: [PhotosPickerItem]) {
        Task {
            var tempImages: [UIImage] = []
            var tempErrorMessage: String?
            
            await withTaskGroup(of: (UIImage?, Error?).self) { taskGroup in
                for photoItem in selectedPhotos {
                    taskGroup.addTask {
                        do {
                            if let imageData = try await photoItem.loadTransferable(type: Data.self),
                               let image = UIImage(data: imageData) {
                                return (image, nil)
                            }
                            return (nil, nil)
                        } catch {
                            return (nil, error)
                        }
                    }
                }
                
                for await result in taskGroup {
                    if let error = result.1 {
                        print(error)
                        tempErrorMessage = "Failed to load one or more images."
                        break
                    } else if let image = result.0 {
                        tempImages.append(image)
                    }
                }
            }
            
            errorMessage = nil
            images.removeAll()
            errorMessage = tempErrorMessage
            images = tempImages
        }
        
    }
    
    @MainActor
    func uploadImage(uid: String) {
        guard let image = images.first else { return }
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        isUploading = true
        firebaseStorageManager.uploadImage(uid: uid, imageData: imageData) { [weak self] result in
            guard let self = self else { return }
            switch (result) {
            case .success(let url):
                updateUserData(uid: uid, imageURL: url)
                isUploading = false
                break
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                isUploading = false
                break
            }
        }
    }
    
    func updateUserData(uid: String, imageURL: URL) {
        self.firestoreManager.updateImageURL(uid: uid, imageURL: imageURL.absoluteString) { result in
            switch (result) {
            case .success():
                break
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                break
            }
        }
    }
}
