//
//  UserView.swift
//  ebuddy
//
//  Created by Rudy Suharyadi on 10/12/24.
//

import SwiftUI

struct UserView: View {
    private var userVM = UserVM()
    
    var body: some View {
        NavigationView {
            List {
                if userVM.isLoading {
                    ProgressView()
                } else if let errorMessage = userVM.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    ForEach(userVM.users, id: \.uid) { user in
                        NavigationLink(destination: PhotoUploadView(user: user)) {
                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: user.imageURL)) { phase in
                                    switch phase {
                                    case .failure:
                                        Image(systemName: "photo").font(.largeTitle)
                                    case .success(let image):
                                        image.resizable()
                                    default:
                                        ProgressView()
                                    }
                                }
                                .frame(width: 256, height: 256)
                                .clipShape(.rect(cornerRadius: 25))
                                Text(user.email)
                                Text(user.phoneNumber)
                                Text(user.gender == GenderEnum.male ? "Male" : "Female")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .onAppear {
                userVM.getUsers()
            }
        }
    }
}
