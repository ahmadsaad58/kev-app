//
//  EditReminderView.swift
//  To Do
//
//  Created by Saad Ahmad on 5/12/25.
//

import SwiftUI

struct EditReminderView: View {
    @Binding var reminder: Reminder
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $reminder.title)
                Toggle(isOn: $reminder.isCompleted) {
                    Text("Completed")
                }
                DatePicker(
                    "Due Date",
                    selection: Binding(
                        get: { reminder.dueDate ?? Date() },
                        set: { reminder.dueDate = $0 }
                    ),
                    displayedComponents: [.date, .hourAndMinute]
                )
            }
            .navigationTitle("Edit Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    EditReminderView(
        reminder: .constant(
            Reminder(
                title: "Sample Reminder",
                isCompleted: true,
                dueDate: Date().addingTimeInterval(3600))
        ))
}
