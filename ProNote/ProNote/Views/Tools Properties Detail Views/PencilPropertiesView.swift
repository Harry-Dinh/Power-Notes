//
//  PencilPropertiesView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-31.
//

import SwiftUI
import PencilKit

struct PencilPropertiesView: View {
    
    @Binding var pencilData: PKInkingTool
    @Binding var selectedToolData: PKTool
    
    @State var pencilStrokeSize: CGFloat
    @State var pencilColor: Color
    
    var body: some View {
        NavigationStack {
            List {
                Slider(value: $pencilStrokeSize, in: 5...15, step: 1) {
                    Text("Pencil Width")
                } minimumValueLabel: {
                    Text("5")
                } maximumValueLabel: {
                    Text("15")
                }
                    .onChange(of: pencilStrokeSize) {
                        pencilData.width = pencilStrokeSize
                        selectedToolData = pencilData
                    }
                
                Text("Stroke Size: \(Float(pencilStrokeSize))")
                
                Section {
                    ColorPicker("Pencil Colour", selection: $pencilColor)
                        .onChange(of: pencilColor) {
                            pencilData.color = UIColor(pencilColor)
                            selectedToolData = pencilData
                        }
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Pencil")
            .navigationBarTitleDisplayMode(.inline)
        }
        .frame(minWidth: 350, minHeight: 350)
    }
}
