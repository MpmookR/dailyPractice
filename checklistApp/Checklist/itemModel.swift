//
//  itemModel.swift
//  week1App
//
//  Created by Mook Rattana on 20/10/2025.
//
import Foundation

struct Item: Identifiable, Codable, Hashable {
    var id = UUID()  // makes every new item unique
    var title: String
    var isDone: Bool = false
}
