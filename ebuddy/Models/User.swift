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
    
    private enum CodingKeys: String, CodingKey {
            case uid
            case email
            case phoneNumber
            case gender
        }
        
    init(uid: String, email: String, phoneNumber: String, gender: GenderEnum) {
        self.uid = uid
        self.email = email
        self.phoneNumber = phoneNumber
        self.gender = gender
    }
    
    
}
