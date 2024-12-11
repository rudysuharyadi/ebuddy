//
//  UserManager.swift
//  ebuddy
//
//  Created by Rudy Suharyadi on 11/12/24.
//

import Observation

@Observable
class UserManager {
    @MainActor
    static let shared = User(
        uid: "",
        email: "",
        phoneNumber: "",
        gender: GenderEnum.male,
        imageURL: ""
    )
}
