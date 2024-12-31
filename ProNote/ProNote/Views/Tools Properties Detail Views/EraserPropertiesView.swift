//
//  EraserPropertiesView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-31.
//

import SwiftUI
import PencilKit

struct EraserPropertiesView: View {
    
    @Binding var eraserData: PKEraserTool
    @Binding var selectedToolData: PKTool
    
    @State var eraserWidth: CGFloat
    @State var eraseEntireStroke: Bool
    @State private var toolbarVM = CustomMarkupToolbarVM.instance
    
    var body: some View {
        NavigationStack {
            List {
                Toggle(isOn: $eraseEntireStroke) {
                    Text("Erase Entire Stroke")
                }
                .onChange(of: eraseEntireStroke) {
                    eraserData.eraserType = toolbarVM.boolToEraserType(eraseEntireStroke)
                    selectedToolData = eraserData
                }
                
                if !eraseEntireStroke {
                    Section {
                        Slider(value: $eraserWidth, in: 10...50, step: 10) {
                            Text("Eraser Stroke")
                        } minimumValueLabel: {
                            Image(systemName: "circle")
                                .imageScale(.small)
                        } maximumValueLabel: {
                            Image(systemName: "circle")
                                .imageScale(.large)
                        }
                        .onChange(of: eraserWidth) {
                            eraserData.width = eraserWidth
                            selectedToolData = eraserData
                        }
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Eraser")
            .navigationBarTitleDisplayMode(.inline)
        }
        .frame(minWidth: 350, minHeight: 350)
    }
}
