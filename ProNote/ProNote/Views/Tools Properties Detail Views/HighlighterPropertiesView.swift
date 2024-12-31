//
//  HighlighterPropertiesView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-30.
//

import SwiftUI
import PencilKit

struct HighlighterPropertiesView: View {
    
    @Binding var highlighterData: PKInkingTool
    @Binding var selectedToolData: PKTool
    
    @State var highlighterColor: Color
    @State var highlighterWidth: CGFloat
    
    var body: some View {
        NavigationStack {
            List {
                Slider(value: $highlighterWidth, in: 10...50, step: 5)
                    .onChange(of: highlighterWidth) {
                        highlighterData.width = highlighterWidth
                        selectedToolData = highlighterData
                    }
                
                Text("Highlighter Width: \(Double(highlighterData.width))")
                
                Section {
                    ColorPicker("Highlighter Colour", selection: $highlighterColor)
                        .onChange(of: highlighterColor) {
                            highlighterData.color = UIColor(highlighterColor)
                            selectedToolData = highlighterData
                        }
                }
                
                Section {
                    Button("Reset to Default Stroke Size", role: .destructive) {
                        highlighterData.width = 20
                        highlighterData.color = .systemYellow
                        selectedToolData = highlighterData
                    }
                }
            }
            .listStyle(.grouped)
        }
        .frame(minWidth: 350, minHeight: 350)
    }
}
