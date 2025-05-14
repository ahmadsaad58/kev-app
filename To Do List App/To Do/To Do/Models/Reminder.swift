//
//  Item.swift
//  To Do
//
//  Created by Saad Ahmad on 5/12/25.
//

import Foundation
import SwiftData

@Model
final class Reminder: Identifiable {
    var id: UUID
    var title: String
    var isCompleted: Bool
    var dateCreated: Date
    var dueDate: Date?

    init(title: String, isCompleted: Bool = false, dueDate: Date? = nil) {
        self.id = UUID()
        self.title = title
        self.isCompleted = isCompleted
        self.dateCreated = Date()
        self.dueDate = dueDate
    }
}


// TODO: Remove this and have data populated from storage
extension Reminder {
    static let samples: [Reminder] = [
        Reminder(title: "Add a Reminder")
    ]
}
