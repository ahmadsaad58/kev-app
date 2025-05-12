//
//  ContentView.swift
//  To Do
//
//  Created by Saad Ahmad on 5/12/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.editMode) private var editMode
    @State private var reminders = Reminder.samples
    @State private var isAddReminderDialogPresented = false
    @State private var selectedReminder: Reminder? = nil

    private func presentAddReminderView() {
        isAddReminderDialogPresented.toggle()
    }

    var body: some View {
        NavigationStack {
            List($reminders, editActions: [.delete, .move]) { $reminder in
                HStack {
                    Image(
                        systemName: reminder.isCompleted
                            ? "checkmark.circle" : "circle"
                    )
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        reminder.isCompleted.toggle()
                    }
                    VStack(alignment: .leading) {
                        Text(reminder.title)
                            .font(.headline)

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
                    .onTapGesture {
                        selectedReminder = reminder
                    }
                }
            }
            .navigationTitle(Text("Reminders"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: presentAddReminderView) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New Reminder")
                        }
                    }
                }
            }
            .sheet(isPresented: $isAddReminderDialogPresented) {
                AddReminderView { reminder in
                    reminders.append(reminder)
                }
            }
            .sheet(item: $selectedReminder) { reminder in
                if let index = reminders.firstIndex(where: {
                    $0.id == reminder.id
                }) {
                    EditReminderView(reminder: $reminders[index])
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Reminder.self, inMemory: false)
}
