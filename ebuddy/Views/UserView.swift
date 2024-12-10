//
//  UserView.swift
//  ebuddy
//
//  Created by Rudy Suharyadi on 10/12/24.
//

import SwiftUI

struct UserView: View {
    private var viewModel = UserVM()
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    ForEach(viewModel.users, id: \.uid) { user in
                        VStack(alignment: .leading) {
                            Text(user.email)
                            Text(user.phoneNumber)
                            Text(user.gender == GenderEnum.male ? "Male" : "Female")
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .onAppear {
                viewModel.getUsers()
            }
        }
    }
}
