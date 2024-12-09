//
//  Item.swift
//  ebuddy
//
//  Created by Rudy Suharyadi on 09/12/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
