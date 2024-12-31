//
//  CustomMarkupToolbarV.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import SwiftUI
import PencilKit

struct CustomMarkupToolbar: View {
    
    @State private var toolbarVM = CustomMarkupToolbarVM.instance
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.thickMaterial)
                .border(width: 0.5, edges: [.bottom, .top], color: .secondary)  // This custom modifier only changes the colour of the top and bottom edges
            
            HStack(alignment: .center) {
                
                // Didn't use a ForEach loop because the popover wouldn't show up properly
                
                Spacer()
                
                // MARK: Fountain Pen Button
                ToolToggle(tool: .fountainPen,
                           selectedTool: $toolbarVM.selectedTool,
                           selectedToolData: $toolbarVM.selectedToolData) {
                    toolbarVM.toggleToolPropertiesView[toolbarVM.toolToIndex(tool: .fountainPen)].toggle()
                }
                           .popover(isPresented: $toolbarVM.toggleToolPropertiesView[toolbarVM.toolToIndex(tool: .fountainPen)]) {
                               FountainPenPropertiesView(penTool: $toolbarVM.fountainPenData,
                                                         selectedToolData: $toolbarVM.selectedToolData,
                                                         penColor: Color(uiColor: toolbarVM.fountainPenData.color),
                                                         penWidth: toolbarVM.fountainPenData.width)
                           }
                
                Spacer()
                
                // MARK: Highlighter Button
                ToolToggle(tool: .highlighter,
                           selectedTool: $toolbarVM.selectedTool,
                           selectedToolData: $toolbarVM.selectedToolData) {
                    toolbarVM.toggleToolPropertiesView[toolbarVM.toolToIndex(tool: .highlighter)].toggle()
                }
                           .popover(isPresented: $toolbarVM.toggleToolPropertiesView[toolbarVM.toolToIndex(tool: .highlighter)]) {
                               HighlighterPropertiesView(highlighterData: $toolbarVM.highlighterData,
                                                         selectedToolData: $toolbarVM.selectedToolData,
                                                         highlighterColor: Color(uiColor: toolbarVM.highlighterData.color),
                                                         highlighterWidth: toolbarVM.highlighterData.width)
                           }
                
                Spacer()
                
                // MARK: Pencil Button
                ToolToggle(tool: .pencil,
                           selectedTool: $toolbarVM.selectedTool,
                           selectedToolData: $toolbarVM.selectedToolData) {
                    toolbarVM.toggleToolPropertiesView[toolbarVM.toolToIndex(tool: .pencil)].toggle()
                }
                           .popover(isPresented: $toolbarVM.toggleToolPropertiesView[toolbarVM.toolToIndex(tool: .pencil)]) {
                               PencilPropertiesView(pencilData: $toolbarVM.pencilData,
                                                    selectedToolData: $toolbarVM.selectedToolData,
                                                    pencilStrokeSize: toolbarVM.pencilData.width,
                                                    pencilColor: Color(uiColor: toolbarVM.pencilData.color))
                           }
                
                Spacer()
                
                ToolToggle(tool: .eraser,
                           selectedTool: $toolbarVM.selectedTool,
                           selectedToolData: $toolbarVM.selectedToolData) {
                    toolbarVM.toggleToolPropertiesView[toolbarVM.toolToIndex(tool: .eraser)].toggle()
                }
                           .popover(isPresented: $toolbarVM.toggleToolPropertiesView[toolbarVM.toolToIndex(tool: .eraser)]) {
                               EraserPropertiesView(eraserData: $toolbarVM.eraserData,
                                                    selectedToolData: $toolbarVM.selectedToolData,
                                                    eraserWidth: toolbarVM.eraserData.width,
                                                    eraseEntireStroke: toolbarVM.eraserTypeToBool(toolbarVM.eraserData.eraserType))
                           }
                
                Spacer()
                
                Toggle(isOn: $toolbarVM.showRuler) {
                    Image("custom-ruler")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 27, height: 27)
                }
                .toggleStyle(.button)
                
                Spacer()
                
                Divider()
                
                Text("Tool-specific actions here...")
                
                Spacer()
            }
            .foregroundStyle(.primary)
        }
        .frame(height: 50)
    }
}

#Preview {
    CustomMarkupToolbar()
}
