//
//  WritingPageView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-21.
//

import SwiftUI
import PencilKit

struct WritingPageView: UIViewRepresentable {
    let canvasView = PKCanvasView()
    
    func makeUIView(context: Context) -> PKCanvasView {
        // Configure view
        canvasView.drawingPolicy = .anyInput
        canvasView.isScrollEnabled = false
        canvasView.backgroundColor = UIColor.systemBackground
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        // No operations
    }
}

#Preview {
    WritingPageView()
}
