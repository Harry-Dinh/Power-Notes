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
                .border(.secondary, width: 2)
                .foregroundStyle(.background, .regularMaterial)
            
            HStack(spacing: 100) {
                Spacer()
                
                Group {
                    Button(action: {}) {
                        Image("custom-fountain-pen")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                    Button(action: {}) {
                        Image("custom-highlighter")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                    Button(action: {}) {
                        Image("custom-pencil")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                    Button(action: {}) {
                        Image("custom-eraser")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                    Button(action: {}) {
                        Image("custom-lasso")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                    Button(action: {}) {
                        Image("custom-ruler")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
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
