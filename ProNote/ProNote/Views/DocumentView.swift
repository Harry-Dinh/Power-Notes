//
//  DocumentView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-25.
//

import SwiftUI
import PDFKit
import PencilKit
import Foundation

struct DocumentView: UIViewRepresentable {
    
    @State private var mainEditVM = MainEditVM.instance
    @Binding var documentWrapper: PDFDocumentWrapper
    @Binding var selectedTool: PKTool
    @Binding var showRuler: Bool
    @Environment(\.undoManager) var undoManager
    
    init(documentWrapper: Binding<PDFDocumentWrapper>, selectedTool: Binding<PKTool>, _ showRuler: Binding<Bool>) {
        self._documentWrapper = documentWrapper
        self._selectedTool = selectedTool
        self._showRuler = showRuler
    }
    
    // MARK: - Make UIView Function
    func makeUIView(context: Context) -> PDFView {
        // Configure the PDF view
        mainEditVM.pdfView.delegate = context.coordinator
        mainEditVM.pdfView.pageOverlayViewProvider = context.coordinator
        mainEditVM.pdfView.autoScales = true
        mainEditVM.pdfView.displayMode = .singlePageContinuous
        mainEditVM.pdfView.displayDirection = .vertical
        mainEditVM.pdfView.displaysPageBreaks = true
        mainEditVM.pdfView.usePageViewController(false)
        mainEditVM.pdfView.isInMarkupMode = true
        mainEditVM.pdfView.document = documentWrapper.document
        
        // Set up the page change observer (for updating the current page index)
        NotificationCenter.default.addObserver(context.coordinator,
                                               selector: #selector(context.coordinator.updateCurrentPageNumber(notification:)),
                                               name: Notification.Name.PDFViewPageChanged,
                                               object: mainEditVM.pdfView)
        
        return mainEditVM.pdfView
    }
    
    // MARK: - Update UIView Function
    func updateUIView(_ uiView: PDFView, context: Context) {
        // Update the currently selected tool
        updateSelectedTool(context)
        
        // Show or hide the ruler
        if context.coordinator.canvasView != nil {
            context.coordinator.canvasView.isRulerActive = showRuler
        }
    }
    
    // MARK: - Make Coordinator Function
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: - Coordinator Class
    class Coordinator: NSObject {
        var parent: DocumentView
        var canvasView: PKCanvasView!
        
        init(_ parent: DocumentView) {
            self.parent = parent
        }
    }
    
    // MARK: - Helper Functions
    
    private func updateSelectedTool(_ context: Context) {
        guard let canvasView = context.coordinator.canvasView else {
            print("Cannot unwrap canvas view")
            return
        }
        canvasView.tool = selectedTool
    }
}

// MARK: - Coordinator Extensions
extension DocumentView.Coordinator: PDFPageOverlayViewProvider, PKCanvasViewDelegate, PDFViewDelegate {
    
    // Set up and overlay the canvas view over each PDF file
    func pdfView(_ view: PDFView, overlayViewFor page: PDFPage) -> UIView? {
        canvasView = PKCanvasView()
        canvasView.delegate = self
        
        let pageBounds = page.bounds(for: .mediaBox)
        canvasView.frame = pageBounds
        
        // Set the resolution so that the ink stroke doesn't look pixelated
        canvasView.contentScaleFactor = view.maxScaleFactor * 2
        
        // Configure the canvas view
        canvasView.drawingPolicy = .default
        canvasView.backgroundColor = .clear
        canvasView.overrideUserInterfaceStyle = .light  // This ensures that the black ink colour doesn't change to white when switching to dark mode
        canvasView.isScrollEnabled = false
        canvasView.isDrawingEnabled = true
        canvasView.tool = parent.selectedTool
        canvasView.isRulerActive = parent.showRuler
        
        // Add a double tap gesture recognizer to zoom the document to its width
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapToZoomGesture))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        canvasView.addGestureRecognizer(doubleTapGestureRecognizer)
        
        return canvasView
    }
    
    // Register any actions take place when the drawing on the canvas changes
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        // Register previous strokes into UndoManager
        registerUndoRedoActions(canvasView)
        
        // Update the page thumbnail on the document sidebar
        // TODO: Call the function here...
    }
    
    // MARK: - Coordinator Helper Functions
    
    @objc func doubleTapToZoomGesture() {
        parent.mainEditVM.pdfView.scaleFactor = parent.mainEditVM.pdfView.scaleFactorForSizeToFit
    }
    
    @objc func updateCurrentPageNumber(notification: Notification) {
        print("updateCurrentPageNumber() called")
        guard let currentPage = parent.mainEditVM.pdfView.currentPage,
              let pageIndex = parent.mainEditVM.pdfView.document?.index(for: currentPage) else {
            print("Unable to get current page")
            return
        }
        parent.mainEditVM.currentPage = pageIndex
        print("Current page index: \(pageIndex)")
    }
    
    // FIXME: This function needs revision!
    private func registerUndoRedoActions(_ canvasView: PKCanvasView) {
        guard let undoManager = parent.undoManager else {
            print("Cannot unwrap undo manager from parent")
            return
        }
        
        undoManager.registerUndo(withTarget: canvasView) { target in
            let previousDrawing = canvasView.drawing
            canvasView.drawing = previousDrawing
            
            undoManager.registerUndo(withTarget: target) { target in
                canvasView.drawing = previousDrawing
            }
        }
    }
}
