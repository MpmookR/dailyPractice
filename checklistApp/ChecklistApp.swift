//
//  ContentView.swift
//  checklistApp
//
//  Created by Mook Rattana on 17/10/2025.
//
import SwiftUI
import Foundation

struct ChecklistApp: View {
    @State private var text: String = ""
    @State private var items: [Item] = [
        Item(title: "Buy groceries", isDone: false),
        Item(title: "Call mom", isDone: false),
    ]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    TextField("Add a new task", text: $text)
                        .submitLabel(.done)
                        .onSubmit { addItem() }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 36).stroke(
                                Color.gray.opacity(0.2),
                                lineWidth: 1
                            )
                        )

                    Button("Add") { addItem() }
                        .buttonStyle(.borderedProminent)
                        .disabled(
                            text.trimmingCharacters(in: .whitespacesAndNewlines)
                                .isEmpty
                        )

                }
                .padding(.horizontal)

                List {
                    ForEach($items) { $item in
                        ChecklistRow(title: item.title, isDone: $item.isDone)
                    }
                    .onDelete(perform: deleteItem)
                }
                .listStyle(.insetGrouped)

                Spacer(minLength: 0)

            }
            .navigationTitle("📍To-Do List")
        }
    }
    private func addItem() {
        let newItem = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !newItem.isEmpty else { return }
        items.append(Item(title: newItem, isDone: false))
        text = ""  //clear text after submit
    }

    private func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)

    }
}

#Preview {
    ContentView()
}

struct ChecklistRow: View {
    let title: String
    @Binding var isDone: Bool

    var body: some View {
        HStack {
            Text(title)
                .strikethrough(isDone)
                .foregroundStyle(isDone ? .gray : .black)
            Spacer()
            Toggle("", isOn: $isDone)
                .labelsHidden()
        }

    }
}

struct Item: Identifiable, Codable, Hashable{
    var id = UUID() // makes every new item unique
    var title: String
    var isDone: Bool = false
}
