//
//  CustomMarkupToolbarVM.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-25.
//

import SwiftUI
import PencilKit

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
    
    // MARK: - Tools Data
    
    // These are use for selecting the current tool on the canvas and updating views
    public var selectedToolData: PKTool = PKInkingTool(.pen, color: .black, width: 5)
    public var selectedTool: ToolButton = .fountainPen
    public var showRuler = false
    
    // These are for storing user preferences and will be stored in UserDefaults so that they can be loaded into the app when it launches
    public var fountainPenData: PKInkingTool = PKInkingTool(.pen, color: .black, width: 5)
    public var highlighterData: PKInkingTool = PKInkingTool(.marker, color: .systemYellow, width: 20)
    public var pencilData: PKInkingTool = PKInkingTool(.pencil, color: .systemBlue, width: 5)
    public var eraserData: PKEraserTool = PKEraserTool(.vector, width: 10)
    
    public func toolToIndex(tool: ToolButton) -> Int {
        switch tool {
            case .fountainPen:
                return 0
            case .highlighter:
                return 1
            case .pencil:
                return 2
            case .eraser:
                return 3
            case .lasso:
                return 4
        }
    }
    
    public func eraserTypeToBool(_ eraserType: PKEraserTool.EraserType) -> Bool {
        if eraserType == .vector {
            return true
        }
        return false    // If the type is bitmap or fixedWidthBitmap
    }
    
    public func boolToEraserType(_ toggleValue: Bool) -> PKEraserTool.EraserType {
        if toggleValue {
            return .vector
        }
        return .bitmap
    }
}
