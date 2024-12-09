//
//  WritingPageView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-21.
//

import SwiftUI

struct PDFViewWrapper: UIViewControllerRepresentable {
    let pdfURL: URL
    @Binding var showMarkupToolbar: Bool
    
    func makeUIViewController(context: Context) -> PDFRenderer {
        let pdfView = PDFRenderer(pdfURL: pdfURL, isExistingNotebook: false)
        pdfView.isDrawingEnabled = showMarkupToolbar    // This ensures that drawing is disabled and the toolbar is hidden at the same time
        return pdfView
    }
    
    func updateUIViewController(_ uiViewController: PDFRenderer, context: Context) {
        uiViewController.isDrawingEnabled = showMarkupToolbar
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: PDFViewWrapper
        weak var pdfVC: PDFRenderer?
        
        init(_ parent: PDFViewWrapper) {
            self.parent = parent
        }
        
        func syncState(with isDrawingModeEnabled: Bool) {
            DispatchQueue.main.async {
                self.parent.showMarkupToolbar = isDrawingModeEnabled
            }
        }
    }
}
