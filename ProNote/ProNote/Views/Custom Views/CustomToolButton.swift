//
//  CustomToolButton.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-25.
//

import SwiftUI

struct CustomToolButton: View {
    @Binding var toggle: CustomToolButtonModel
    var changeToolAction: () -> Void
    
    var body: some View {
        Toggle(isOn: $toggle.isSelected) {
            Image(toggle.iconName)
                .resizable()
                .frame(width: 25, height: 25)
        }
        .toggleStyle(.button)
        .foregroundStyle(.primary)
        .onChange(of: toggle.isSelected) {
            changeToolAction()
        }
        .onTapGesture {
            if toggle.isSelected {
                // TODO: Open tool context menu
                print("Open tool context menu")
            } else {
                print("Tool select action")
                changeToolAction()
            }
        }
    }
}
