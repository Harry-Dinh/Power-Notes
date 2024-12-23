//
//  WritingPageView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-21.
//

import SwiftUI
import PDFKit

struct PDFViewWrapper: UIViewControllerRepresentable {
    private let document: PDFDocument?
    
    init(document: PDFDocument?) {
        self.document = document
    }
    
    func makeUIViewController(context: Context) -> PDFRenderer {
        let pdfView = PDFRenderer(document: document)
        return pdfView
    }
    
    func updateUIViewController(_ uiViewController: PDFRenderer, context: Context) {
        // No operations
    }
}
