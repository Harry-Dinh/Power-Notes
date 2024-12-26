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
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.bar)
                .border(width: 0.5, edges: [.bottom, .top], color: .secondary)  // This custom modifier only changes the colour of the top and bottom edges
            
            HStack(alignment: .center) {
                
                Group {
                    ForEach($toolbarVM.toggleButtons) { $tool in
                        Spacer()
                        CustomToolButton(toggle: $tool) {
                            toolbarVM.selectToggle(id: tool.id)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image("custom-ruler")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 27, height: 27)
                    }
                    
                    Spacer()
                    
                    Divider()
                    
                    Text("Tool-specific actions here...")
                }
                .foregroundStyle(Color.primary)
                
                Spacer()
            }
        }
        .frame(height: 50)
    }
}

#Preview {
    CustomMarkupToolbar()
}
