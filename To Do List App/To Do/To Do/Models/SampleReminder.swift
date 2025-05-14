//
//  SampleReminder.swift
//  To Do
//
//  Created by Saad Ahmad on 5/13/25.
//

import Foundation

/// For Previews and Testing
extension Reminder {
    static let samples: [Reminder] = [
        Reminder(
            title: "Add a Reminder",
            isCompleted: false,
            dueDate: Date().addingTimeInterval(3600)
        )
    ]
    
}
