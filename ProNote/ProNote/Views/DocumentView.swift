//
//  DocumentView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-25.
//

import SwiftUI
import PDFKit
import PencilKit

struct DocumentView: UIViewRepresentable {
    
    private var pdfView = PDFView()
    @Binding var documentWrapper: PDFDocumentWrapper
    
    init(documentWrapper: Binding<PDFDocumentWrapper>) {
        self._documentWrapper = documentWrapper
    }
    
    // MARK: - Make UIView Function
    func makeUIView(context: Context) -> PDFView {
        // Configure the PDF view
        pdfView.delegate = context.coordinator
        pdfView.pageOverlayViewProvider = context.coordinator
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.displaysPageBreaks = true
        pdfView.usePageViewController(false)
        pdfView.isInMarkupMode = true
        pdfView.document = documentWrapper.document
        return pdfView
    }
    
    // MARK: - Update UIView Function
    func updateUIView(_ uiView: PDFView, context: Context) {
        // No operations yet...
    }
    
    // MARK: - Make Coordinator Function
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: - Coordinator Class
    class Coordinator: NSObject, PDFViewDelegate {
        var parent: DocumentView
        
        init(_ parent: DocumentView) {
            self.parent = parent
        }
    }
}

// MARK: - Coordinator Extensions
extension DocumentView.Coordinator: PDFPageOverlayViewProvider, PKCanvasViewDelegate {
    
    // Set up and overlay the canvas view over each PDF file
    func pdfView(_ view: PDFView, overlayViewFor page: PDFPage) -> UIView? {
        let canvasView = PKCanvasView()
        canvasView.delegate = self
        
        let pageBounds = page.bounds(for: .mediaBox)
        canvasView.frame = pageBounds
        
        // Set the resolution so that the ink stroke doesn't look pixelated
        canvasView.contentScaleFactor = view.maxScaleFactor * 2
        
        // Configure the canvas view
        canvasView.drawingPolicy = .default
        canvasView.backgroundColor = .clear
        canvasView.overrideUserInterfaceStyle = .light
        canvasView.isScrollEnabled = false
        canvasView.isDrawingEnabled = true
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 5)
        
        // Add a double tap gesture recognizer to zoom the document to its width
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapToZoomGesture))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        canvasView.addGestureRecognizer(doubleTapGestureRecognizer)
        
        return canvasView
    }
    
    @objc func doubleTapToZoomGesture() {
        parent.pdfView.scaleFactor = parent.pdfView.scaleFactorForSizeToFit
    }
}
