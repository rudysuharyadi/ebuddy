//
//  Gender.swift
//  ebuddy
//
//  Created by Rudy Suharyadi on 09/12/24.
//

enum GenderEnum: Int, CaseIterable, Identifiable, Codable {
    case male = 0
    case female = 1
    var id: Self { self }
}
