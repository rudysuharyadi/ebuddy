//
//  PhotoUploadView.swift
//  ebuddy
//
//  Created by Rudy Suharyadi on 11/12/24.
//

import SwiftUI
import PhotosUI

struct PhotoUploadView: View {
    var user:User
    @Bindable private var photoUploadVM = PhotoUploadVM()
    
    private var photoPickerSection: some View {
        Section {
            PhotosPicker(selection: $photoUploadVM.selectedPhotos, maxSelectionCount: 1, matching: .images) {
                Label("Select a photo", systemImage: "photo")
            }
            .onChange(of: photoUploadVM.selectedPhotos, { oldValue, newValue in
                photoUploadVM.loadSelectedPhotos(selectedPhotos: newValue)
            })
        }
    }
    
    private var imagesSection: some View {
        Section {
            ForEach(photoUploadVM.images, id: \.self) { image in
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    .padding(.vertical, 10)
            }
        }
    }
    
    var body: some View {
        VStack {
            Form {
                photoPickerSection
                imagesSection
                if let image = photoUploadVM.images.first {
                    if photoUploadVM.isUploading {
                        ProgressView()
                    } else {
                        Button("Upload", action: {
                            photoUploadVM.uploadImage(uid: user.uid ?? UUID().uuidString)
                        })
                    }
                }
            }
            if let errorMessage = photoUploadVM.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
    
    
}
