//
//  GenderVM.swift
//  ebuddy
//
//  Created by Rudy Suharyadi on 09/12/24.
//

import Foundation
import Observation

@Observable class UserVM {
    var users: [User] = []
    var isLoading = false
    var errorMessage: String?
    
    private let firestoreManager = FirestoreManager()
    
    func getUsers() {
        isLoading = true
        firestoreManager.getAllUsers { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                print("Error fetching user: \(error)")
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
