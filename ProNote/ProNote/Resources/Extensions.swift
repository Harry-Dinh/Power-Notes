//
//  Extensions.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-24.
//

import SwiftUI

extension View {
    
    /// Source: https://stackoverflow.com/questions/58632188/swiftui-add-border-to-one-edge-of-an-image/58632759#58632759
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundStyle(color))
    }
}
