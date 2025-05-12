//
//  ContentView.swift
//  SwiftList
//
//  Created by Saad Ahmad on 5/11/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [Task]
    @State private var showAdd = false
    @State private var newTitle = "New Task"

    var body: some View {

        NavigationSplitView {
            
            List {
                ForEach(tasks) { task in
                    NavigationLink {
                        Text("Task at \(task.title)")
                    } label: {
                        Text(task.title)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(showAdd = true) {
                        Label("Add Item", systemImage: "plus")
                    }
                    .alert("Add Task",
                           isPresented: $showAdd,
                           actions: {
                        TextField("Title", text: $newTitle)
                        Button("Save") {
                            tasks.append(newTitle)
                            newTitle = ""
                        }.disabled(newTitle.isEmpty)
                        Button("Cancel", role: .cancel) { newTitle = "" }
                    },
                           message: { Text("Enter a short title") })
                }
            }
            ToolbarItem {
                Button(action: deleteAllItems) {
                    Label("Delete All", systemImage: "trash.fill")
                }
            }
        }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem(title: String) {
        withAnimation {
            let newTask = Task(title: title)
            modelContext.insert(newTask)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(tasks[index])
            }
        }
    }

    private func deleteAllItems() {
        withAnimation {
            for task in tasks {
                modelContext.delete(task)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self, inMemory: true)
}
