//
//  CustomMarkupToolbarV.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import SwiftUI

struct CustomMarkupToolbar: View {
    var body: some View {
        // TODO: Customize this a bit later, just need to get the functionality working first!
        ZStack {
            Rectangle()
                .foregroundStyle(.bar)
                .border(width: 0.5, edges: [.bottom, .top], color: .secondary)  // This custom modifier only changes the colour of the top and bottom edges
            
            HStack {
                Spacer()
                
                Group {
                    Button(action: {}) {
                        Image("custom-fountain-pen")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image("custom-highlighter")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image("custom-pencil")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image("custom-eraser")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image("custom-lasso")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image("custom-ruler")
                            .resizable()
                            .frame(width: 30, height: 30)
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
