//
//  Item.swift
//  SwiftList
//
//  Created by Saad Ahmad on 5/11/25.
//

import Foundation
import SwiftData

@Model
final class Task {
    var title: String
    var isDone: Bool = false
    
    init(title: String) {
        self.title = title
    }
}
