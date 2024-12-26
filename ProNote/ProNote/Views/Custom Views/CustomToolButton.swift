//
//  CustomToolButton.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-25.
//

import SwiftUI
import PencilKit

struct ToolToggle: View {
    let tool: CustomMarkupToolbarVM.ToolButton
    @Binding var selectedTool: CustomMarkupToolbarVM.ToolButton
    @Binding var selectedToolData: PKTool
    var toolAction: () -> Void
    
    var body: some View {
        Button(action: {
            if selectedTool == tool {
                toolAction()
            } else {
                switch tool {
                    case .fountainPen:
                        print("Switched to pen tool")
                        selectedToolData = PKInkingTool(.pen, color: .black, width: 5)
                    case .highlighter:
                        print("Switched to highlighter tool")
                        selectedToolData = PKInkingTool(.marker, color: .systemYellow, width: 5)
                    case .pencil:
                        print("Switched to pencil tool")
                        selectedToolData = PKInkingTool(.pencil, color: .systemBlue, width: 5)
                    case .eraser:
                        print("Switched to eraser")
                        selectedToolData = PKEraserTool(.vector, width: 3)
                    case .lasso:
                        print("Switched to lasso tool")
                        selectedToolData = PKLassoTool()
                }
                selectedTool = tool
            }
        }) {
            Image(tool.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(.primary)
                .padding(7)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(selectedTool == tool ? Color.accentColor.opacity(0.25) : Color.clear)
                }
        }
    }
}
