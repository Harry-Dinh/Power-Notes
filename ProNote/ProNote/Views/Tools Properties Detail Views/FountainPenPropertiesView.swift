//
//  FountainPenPropertiesView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-30.
//

import SwiftUI
import PencilKit

struct FountainPenPropertiesView: View {
    
    @Binding var penTool: PKInkingTool
    @Binding var selectedToolData: PKTool
    
    @State var penColor: Color
    @State var penWidth: CGFloat
    
    var body: some View {
        NavigationStack {
            List {
                Slider(value: $penWidth, in: 0...15, step: 0.5) {
                    Text("Stroke Size")
                } minimumValueLabel: {
                    Text("1")
                } maximumValueLabel: {
                    Text("15")
                }
                .onChange(of: penWidth) {
                    penTool.width = penWidth
                    selectedToolData = penTool  // This updates the selected tool data on the main canvas so that it looks like it updated in real-time
                }
                
                Text("Stroke Size: \(Double(penTool.width))")
                
                Section {
                    ColorPicker("Stroke Colour", selection: $penColor)
                        .onChange(of: penColor) {
                            penTool.color = UIColor(penColor)
                            selectedToolData = penTool  // This updates the selected tool data on the main canvas so that it looks like it updated in real-time
                        }
                }
                
                Section {
                    Button("Reset to Default Stroke Size") {
                        penTool.width = 5
                        selectedToolData = PKInkingTool(.pen, color: .black, width: 5)  // Reset to the default configurations
                    }
                }

            }
            .navigationTitle("Fountain Pen")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.grouped)
        }
        .frame(minWidth: 350, minHeight: 350)
    }
}
