//
//  CustomMarkupToolbarV.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import SwiftUI

struct CustomMarkupToolbar: View {
    
//    @State private var primaryVM = PrimaryVM.instance
    @State private var toolbarVM = CustomMarkupToolbarVM.instance
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.thickMaterial)
                .border(width: 0.5, edges: [.bottom, .top], color: .secondary)  // This custom modifier only changes the colour of the top and bottom edges
            
            HStack(alignment: .center) {
                
                ForEach(CustomMarkupToolbarVM.ToolButton.allCases, id: \.self) { tool in
                    Spacer()
                    ToolToggle(tool: tool, selectedTool: $toolbarVM.selectedTool) {
                        // Open specific tool actions here...
                    }
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
