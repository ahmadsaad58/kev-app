//
//  ReminderView.swift
//  To Do
//
//  Created by Saad Ahmad on 5/12/25.
//

import SwiftUI

struct AddReminderView: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: FocusableField?
    @State private var reminder = Reminder(title: "")
    @State private var reminderDate = Date()

    var onCommit: (_ reminder: Reminder) -> Void

    var body: some View {
        renderAddForm
            .navigationViewModifier(
                "New Reminder",
                onCancel: { dismiss() },
                onConfirm: {
                    onCommit(reminder)
                    dismiss()
                },
                confirmText: "Add",
                onConfirmDisabled: reminder.title.isEmpty,
                onAppear: {
                    focusedField = .title
                }
            )
    }

    /// View for Add Reminder Form
    private var renderAddForm: some View {
        Form {
            TextField("Title", text: $reminder.title)
                .focused($focusedField, equals: .title)
            DatePicker(
                "Due Date",
                selection: Binding<Date>(
                    get: { reminder.dueDate ?? Date() },
                    set: { reminder.dueDate = $0 }
                ),
                displayedComponents: [.date, .hourAndMinute]
            )
            .datePickerStyle(CompactDatePickerStyle())
        }
    }
}

#Preview {
    AddReminderView { reminder in
        print("You added a new reminder titled \(reminder.title)")
    }
    .modelContainer(for: Reminder.self, inMemory: false)
}
