//
//  CounterVM.swift
//  week1App
//
//  Created by Mook Rattana on 20/10/2025.
//
import SwiftUI
import Combine

final class CounterVM: ObservableObject {
    
    @Published var count: Int = 0
    private let max: Int = 10
    
    var isAtMax: Bool { count >= max }
    var isAtMin: Bool { count <= 0 }
    
    var canIncrement: Bool { !isAtMax }
    var canDecrement: Bool { !isAtMin }
    
    init(count: Int) {
        self.count = count
    }

    func increment() {
        guard canIncrement else { return }
        count += 1
    }
    
    func decrement() {
        guard canDecrement else { return }
        count -= 1

    }
}
