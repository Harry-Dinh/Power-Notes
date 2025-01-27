//
//  DocumentOverviewView.swift
//  ProNote
//
//  Created by Harry Dinh on 2025-01-26.
//

import SwiftUI
import PDFKit

struct DocumentOverviewView: UIViewRepresentable {
    
    @State private var mainEditVM = MainEditVM.instance
    
    func makeUIView(context: Context) -> UIScrollView {
        // Initialize the scroll view
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.backgroundColor = .systemBackground
        
        // Create the thumbnail view
        let thumbnailView = PDFThumbnailView()
        thumbnailView.pdfView = mainEditVM.pdfView
        thumbnailView.layoutMode = .vertical
        thumbnailView.thumbnailSize = CGSize(width: 80, height: 100)
        thumbnailView.sizeToFit()
        
        // Set frame for the thumbnail view and calculate height dynamically
        let numColumns = 4
//        let containerWidth = scrollView.bounds.width
        let calculatedWidth = CGFloat(numColumns) * thumbnailView.thumbnailSize.width
        let rows = ceil(CGFloat(mainEditVM.pdfView.document?.pageCount ?? 0) / CGFloat(numColumns))
        let calculatedheight = rows * thumbnailView.thumbnailSize.height + 20
        thumbnailView.frame = CGRect(x: 0, y: 0, width: calculatedWidth, height: calculatedheight)
        
        // Add the thumbnail view to the scroll view
        scrollView.addSubview(thumbnailView)
        scrollView.contentSize = thumbnailView.bounds.size
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // No operations... yet
    }
}
