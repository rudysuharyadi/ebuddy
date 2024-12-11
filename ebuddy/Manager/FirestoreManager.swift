//
//  FirestoreManager.swift
//  ebuddy
//
//  Created by Rudy Suharyadi on 09/12/24.
//

import FirebaseFirestore

class FirestoreManager {
    private let db = Firestore.firestore()
    
    func getAllUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        db.collection("USERS").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let users = try snapshot?.documents.compactMap {
                    try $0.data(as: User.self)
                } ?? []
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func updateImageURL(uid: String, imageURL: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let userRef = db.collection("USERS").document(uid)
        userRef.updateData(["imageURL": imageURL]) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            print("updated")
            completion(.success(()))
        }
    }
    
}
