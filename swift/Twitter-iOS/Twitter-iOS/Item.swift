//
//  Item.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/09.
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
