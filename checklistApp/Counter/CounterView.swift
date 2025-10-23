//
//  CounterView.swift
//  week1App: counterApp
//  Start at 0, increases n decreases by 1 and disabled at 0
//
//  Created by Mook Rattana on 20/10/2025.
//
import SwiftUI

struct CounterView: View {
    
    @StateObject var vm = CounterVM(count: 0)
    
    var body: some View{
        HStack(spacing: 18){
            ButtonCounter(
                action: {vm.decrement()},
                label: "-",
                isActive: vm.canDecrement
            )
            Text("\(vm.count)")
            ButtonCounter(
                action: {vm.increment()},
                label: "+",
                isActive: vm.canIncrement
            )
        }
    }
}

#Preview {
    CounterView()
}

struct ButtonCounter: View {
    var action: () -> Void
    var label: String
    var isActive: Bool
    
    var body: some View{
        Button(action:action){
            Text(label)
                .padding(.horizontal, 8)
                .padding(.vertical,2)
                .foregroundStyle(isActive ? Color.accentColor : .gray)
                .background(isActive ? Color.blue.opacity(0.1) : .gray.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 99)
                        .stroke(isActive ? .blue : .gray)
                )
        }
        .cornerRadius(99)
    }
}

#Preview{
    ButtonCounter(
        action: {},
        label: "+",
        isActive: false
    )
}
