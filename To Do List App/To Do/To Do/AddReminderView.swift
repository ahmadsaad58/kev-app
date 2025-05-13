//
//  ReminderView.swift
//  To Do
//
//  Created by Saad Ahmad on 5/12/25.
//

import SwiftUI

struct AddReminderView: View {
    enum FocusableField: Hashable {
        case title
    }

    @FocusState private var focusedField: FocusableField?
    @Environment(\.dismiss) private var dismiss
    var onCommit: (_ reminder: Reminder) -> Void

    @State private var reminder = Reminder(title: "")
    @State private var reminderDate = Date()

    var body: some View {
        NavigationStack {
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

            .navigationTitle("New Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: cancel)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", action: commit)
                        .disabled(reminder.title.isEmpty)
                }
            }
            .onAppear {
                focusedField = .title
            }
        }

    }

    private func commit() {
        onCommit(reminder)
        dismiss()
    }

    private func cancel() {
        dismiss()
    }
}

#Preview {
    AddReminderView { reminder in
        print("You added a new reminder titled \(reminder.title)")
    }

}
