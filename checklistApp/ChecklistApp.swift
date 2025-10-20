import Combine
import Foundation
//
//  ContentView.swift
//  checklistApp
//
//  Created by Mook Rattana on 17/10/2025.
//
import SwiftUI

struct ChecklistApp: View {
    @StateObject private var vm = ChecklistVM()
    @AppStorage("checklistData") private var savedData = Data()  // storage

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    TextField("Add a new task", text: $vm.text)
                        .submitLabel(.done)
                        .onSubmit { vm.addItem() }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 36).stroke(
                                Color.gray.opacity(0.2),
                                lineWidth: 1
                            )
                        )

                    Button("Add") { vm.addItem() }
                        .buttonStyle(.borderedProminent)
                        .disabled(
                            vm.text.trimmingCharacters(
                                in: .whitespacesAndNewlines
                            )
                            .isEmpty
                        )

                }
                .padding(.horizontal)
                .toolbar(content: { EditButton() })

                List {
                    ForEach($vm.items) { $item in
                        ChecklistRow(title: item.title, isDone: $item.isDone)
                    }
                    .onDelete(perform: vm.removeItem)
                    .onMove { indices, newOffset in
                        vm.items.move(fromOffsets: indices, toOffset: newOffset)
                    }
                }
                .listStyle(.insetGrouped)

                Spacer()

            }
            .navigationTitle("📍To-Do List")
        }
        // presistence hooks
        .onAppear{ load() }
        .onChange(of: vm.items){ save() }
    }
    private func save() {
        if let data = try? JSONEncoder().encode(vm.items) {
            savedData = data
        }
    }
    private func load() {
        if let decoded = try? JSONDecoder().decode(
            [Item].self,
            from: savedData
        ),
            !decoded.isEmpty
        {
            vm.items = decoded
        } else {
            vm.items = [Item(title: "Buy Grocery")]
        }
    }

}

#Preview {
    ChecklistApp()
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

// model
struct Item: Identifiable, Codable, Hashable {
    var id = UUID()  // makes every new item unique
    var title: String
    var isDone: Bool = false
}

@MainActor
final class ChecklistVM: ObservableObject {
    @Published var items: [Item] = []
    @Published var text = ""

    //addItem
    // shared state - text between view and vm
    /// vm can update it internally
    func addItem() {
        let t = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !t.isEmpty else { return }
        items.append(Item(title: t))
        text = ""
    }
    //reMoveItem
    // parameter tells which row to remove : user selection
    func removeItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
