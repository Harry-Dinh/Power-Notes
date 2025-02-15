//
//  ColorButton.swift
//  ProNote
//
//  Created by Harry Dinh on 2025-02-15.
//

import SwiftUI

struct ColorButton: View {
    
    var color: Color
    
    var body: some View {
        Button(action: {}) {
            color
                .clipShape(Circle())
                .frame(width: PNConstants.COLOR_BUTTON_DIMENSION, height: PNConstants.COLOR_BUTTON_DIMENSION)
        }
    }
}
