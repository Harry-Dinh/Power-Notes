//
//  WritingPageView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-21.
//

import SwiftUI
import PencilKit

// TODO: Might want to replace this standard PKCanvasView with a PDFPageView instead...

struct WritingPageView: UIViewControllerRepresentable {
    let pdfURL: URL
    
    func makeUIViewController(context: Context) -> PDFWithAnnotationsVC {
        PDFWithAnnotationsVC(pdfURL: pdfURL)
    }
    
    func updateUIViewController(_ uiViewController: PDFWithAnnotationsVC, context: Context) {
        // No operations... for now
    }
}
