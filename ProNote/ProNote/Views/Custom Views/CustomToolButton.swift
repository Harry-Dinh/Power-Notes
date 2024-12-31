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
    
    @State private var toolbarVM = CustomMarkupToolbarVM.instance
    
    var body: some View {
        Button(action: {
            if selectedTool == tool {
                toolAction()
            } else {
                switch tool {
                    case .fountainPen:
                        print("Switched to pen tool")
                        selectedToolData = toolbarVM.fountainPenData
                    case .highlighter:
                        print("Switched to highlighter tool")
                        selectedToolData = toolbarVM.highlighterData
                    case .pencil:
                        print("Switched to pencil tool")
                        selectedToolData = toolbarVM.pencilData
                    case .eraser:
                        print("Switched to eraser")
                        selectedToolData = toolbarVM.eraserData
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
