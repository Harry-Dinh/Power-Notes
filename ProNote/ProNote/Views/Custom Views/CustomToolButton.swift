//
//  CustomToolButton.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-25.
//

import SwiftUI

struct ToolToggle: View {
    let tool: CustomMarkupToolbarVM.ToolButton
    @Binding var selectedTool: CustomMarkupToolbarVM.ToolButton
    var toolAction: () -> Void
    
    var body: some View {
        Button(action: {
            if selectedTool == tool {
                toolAction()
            } else {
                selectedTool = tool
                // TODO: Also change the actual selected tool here...
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
