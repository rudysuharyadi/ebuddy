//
//  Users.swift
//  ebuddy
//
//  Created by Rudy Suharyadi on 09/12/24.
//

import Foundation
import FirebaseFirestore

struct User: Codable {
    @DocumentID var uid: String?
    var email: String
    var phoneNumber: String
    var gender: GenderEnum
    var imageURL: String
    
    private enum CodingKeys: String, CodingKey {
            case uid
            case email
            case phoneNumber
            case gender
            case imageURL
        }
        
    init(uid: String, email: String, phoneNumber: String, gender: GenderEnum, imageURL: String) {
        self.uid = uid
        self.email = email
        self.phoneNumber = phoneNumber
        self.gender = gender
        self.imageURL = imageURL
    }
    
    
}
