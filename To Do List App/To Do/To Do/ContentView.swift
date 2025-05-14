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

    private func addReminder(_ r: Reminder) {
        modelContext.insert(r)
    }

    var body: some View {
        NavigationStack {
            List($reminders, editActions: [.delete, .move]) { $reminder in
                ReminderRowView(reminder: reminder)
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
                    EditReminderView(
                        reminder: Binding(
                            get: { reminders[index] },
                            set: { reminders[index] = $0 }
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Reminder.self, inMemory: false)
}
