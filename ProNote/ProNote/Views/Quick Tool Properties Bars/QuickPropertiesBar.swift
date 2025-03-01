//
//  QuickPropertiesBar.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-26.
//

import SwiftUI

struct QuickPropertiesBar: View {
    
    @State private var selectedColor = Color.accentColor
    
    var body: some View {
        ZStack {
            ScrollView(.horizontal) {
                HStack(spacing: 25) {
                    // TODO: This is just a placeholder for now, replace this with a dynamically changing view instead!
                    ColorButton(color: .red)
                    ColorButton(color: .blue)
                    ColorButton(color: .yellow)
                }
            }
            
            HStack(spacing: 25) {
                Spacer(minLength: 10)
                
                ColorPicker(selection: $selectedColor) {
                    Text("")
                }
                .frame(maxWidth: 30)
                
                Button(action: {}) {
                    Image(systemName: "plus")
                        .symbolVariant(.circle)
                        .imageScale(.large)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    CustomMarkupToolbar()
}
