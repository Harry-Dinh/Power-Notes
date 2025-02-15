//
//  AllThumbnailsView.swift
//  ProNote
//
//  Created by Harry Dinh on 2025-01-04.
//

import SwiftUI
import PDFKit

struct AllThumbnailsView: UIViewRepresentable {
    
    @Binding var notebook: PNNotebookWrapper
    
    func makeUIView(context: Context) -> PDFThumbnailView {
        print("AllThumbnailsView.makeUIView() called")
        
        // MARK: Set up the associated PDF view
        guard let notebook = notebook.notebook,
              let document = notebook.document else {
            fatalError("Cannot unwrap notebook and/or document")
        }
        
        let pdfView = PDFView()
        pdfView.document = document
        pdfView.autoScales = false
        pdfView.displayDirection = .vertical
        pdfView.displayMode = .twoUpContinuous
        pdfView.delegate = context.coordinator
        
        // MARK: Initialize and set up PDFThumbnailView
        let thumbnailView = PDFThumbnailView()
        thumbnailView.layoutMode = .vertical
        thumbnailView.pdfView = pdfView
        thumbnailView.backgroundColor = .systemBackground
        thumbnailView.thumbnailSize = CGSize(width: 150, height: 150)
        return thumbnailView
    }
    
    func updateUIView(_ uiView: PDFThumbnailView, context: Context) {
        // No operations... yet
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: AllThumbnailsView
        
        init(_ parent: AllThumbnailsView) {
            self.parent = parent
        }
    }
}

extension AllThumbnailsView.Coordinator: PDFViewDelegate {
    
}
