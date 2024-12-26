//
//  CustomMarkupToolbarVM.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-25.
//

import SwiftUI

@Observable
class CustomMarkupToolbarVM {
    
    public static let instance = CustomMarkupToolbarVM()
    
    public var toggleButtons: [CustomToolButtonModel] = [
        CustomToolButtonModel(iconName: "custom-fountain-pen", isSelected: true),
        CustomToolButtonModel(iconName: "custom-highlighter", isSelected: false),
        CustomToolButtonModel(iconName: "custom-pencil", isSelected: false),
        CustomToolButtonModel(iconName: "custom-eraser", isSelected: false),
        CustomToolButtonModel(iconName: "custom-lasso", isSelected: false)
    ]
    
    public func selectToggle(id: UUID) {
        for i in toggleButtons.indices {
            toggleButtons[i].isSelected = toggleButtons[i].id == id
        }
    }
}
