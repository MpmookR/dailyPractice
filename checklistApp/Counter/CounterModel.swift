//
//  CounterModel.swift
//  week1App
//
//  Created by Mook Rattana on 20/10/2025.
//
import Foundation

struct counter: Identifiable, Hashable, Codable {
    var id = UUID()
    var count: Int
    var max: Int = 10   // max 10
}

extension counter {
    var isAtMax: Bool {count >= max}
    var isAtMin: Bool {count <= 0}
    var isActive: Bool {!isAtMax && !isAtMin}
}

