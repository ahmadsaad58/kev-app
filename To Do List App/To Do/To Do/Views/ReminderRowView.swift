//
//  ReminderRowView.swift
//  To Do
//
//  Created by Saad Ahmad on 5/13/25.
//

import Foundation
import SwiftUI

struct ReminderRowView: View {
    var reminder: Reminder

    var body: some View {
        HStack {
            renderIsCompletedCircle
            renderReminderText
        }
    }

    /// View for Reminder isCompleted circle
    private var renderIsCompletedCircle: some View {
        Image(
            systemName: reminder.isCompleted
                ? "checkmark.circle" : "circle"
        )
        .imageScale(.large)
        .foregroundColor(.accentColor)
        .onTapGesture {
            reminder.isCompleted.toggle()
        }
    }

    /// View for Reminder title
    private var renderReminderText: some View {
        VStack(alignment: .leading) {
            Text(reminder.title)
                .font(.headline)
            renderDueDate
        }
    }

    /// View for Reminder dueDate
    private var renderDueDate: some View {
        if let dueDate = reminder.dueDate {
            Text(
                "Due: \(dueDate, style: .date) at \(dueDate, style: .time)"
            )
            .font(.subheadline)
            .foregroundColor(.gray)
        } else {
            Text("No due date")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }

}

/// Render ReminderRowView
#Preview {
    ReminderRowView(
        reminder: Reminder.samples[0]
    )
    .modelContainer(for: Reminder.self, inMemory: false)
}
