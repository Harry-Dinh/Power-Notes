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
    
    public enum ToolButton: String, CaseIterable {
        case fountainPen = "custom-fountain-pen"
        case highlighter = "custom-highlighter"
        case pencil = "custom-pencil"
        case eraser = "custom-eraser"
        case lasso = "custom-lasso"
    }
    
    public var toggleToolPropertiesView: [Bool] = [
        false,
        false,
        false,
        false,
        false
    ]
    
    public var selectedTool: ToolButton = .fountainPen
    public var showRuler = false
}
