//
//  CustomThumbnailView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-21.
//

import SwiftUI
import PDFKit

struct CustomScrollableThumbnailView: UIViewRepresentable {
    let pdfURL: URL!
    
    @State private var primaryVM = PrimaryVM.instance
    
    init(pdfURL: URL) {
        self.pdfURL = pdfURL
    }
    
    func makeUIView(context: Context) -> PDFThumbnailView {
        // Set up the metadata for the thumbnail view
        let document = PDFDocument(url: pdfURL)
        let pdfView = PDFView()
        pdfView.document = document
        
        // Set up the thumbnail view
        let thumbnailView = PDFThumbnailView()
        thumbnailView.pdfView = pdfView
        thumbnailView.backgroundColor = .clear
        thumbnailView.layoutMode = .horizontal
        thumbnailView.thumbnailSize = CGSize(width: 200, height: 200)
        return thumbnailView
    }
    
    func updateUIView(_ uiView: PDFThumbnailView, context: Context) {
        // No operations...
    }
}

#Preview {
    NoteCreationView()
}
