//
//  ChecklistVM.swift
//  week1App
//
//  Created by Mook Rattana on 20/10/2025.
//
import Combine
import SwiftUI

@MainActor
class ChecklistVM: ObservableObject {
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
