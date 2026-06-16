//
//  PDFMarkupView.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-31.
//

import SwiftUI
import PDFKit
import PencilKit

struct PDFMarkupView: UIViewRepresentable {
    @Binding var note: PNNote
    @Bindable var noteEditingViewModel: NoteEditingViewModel
    
    var pdfView = PDFView()
    var selectedTool: PKTool {
        noteEditingViewModel.selectedTool?.pkTool ?? Constants.defaultSelectedTool
    }
    var isDrawingEnabled: Bool {
        noteEditingViewModel.isToolkitVisible
    }
    
    init(note: Binding<PNNote>, _ noteEditingViewModel: NoteEditingViewModel) {
        self._note = note
        self.noteEditingViewModel = noteEditingViewModel
    }
    
    func makeUIView(context: Context) -> PDFView {
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.autoScales = true
        pdfView.backgroundColor = .secondarySystemBackground
        pdfView.delegate = context.coordinator
        pdfView.isInMarkupMode = isDrawingEnabled
        pdfView.pageOverlayViewProvider = context.coordinator
        pdfView.usePageViewController(true)
        
        pdfView.document = note.pdfDocument
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        context.coordinator.parent = self
        
        /*
         Declaring this outside of the loop to make SwiftUI notice the update to listen to.
         Because when the view first appears, there will be no views in the PDF document, it has to load in first.
         Due to that, the code inside the loop never gets run, making SwiftUI not know when to start listening to updates.
         */
        let currentTool = selectedTool
        let currentDrawingState = isDrawingEnabled
        
        for view in context.coordinator.pageToViewMapping.values {
            if let canvasView = view as? PKCanvasView {
                canvasView.tool = currentTool
                canvasView.isDrawingEnabled = currentDrawingState
            }
        }
        uiView.isInMarkupMode = isDrawingEnabled
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, PDFPageOverlayViewProvider, PDFViewDelegate, PDFDocumentDelegate {
        var parent: PDFMarkupView
        
        var pageToViewMapping = [PDFPage: UIView]()
        
        init(_ parent: PDFMarkupView) {
            self.parent = parent
        }
        
        func pdfView(_ view: PDFView, overlayViewFor page: PDFPage) -> UIView? {
            var resultView: PKCanvasView? = nil
            
            if let overlayView = pageToViewMapping[page] as? PKCanvasView {
                resultView = overlayView
            } else {
                let canvasView = PKCanvasView(frame: .zero)
                canvasView.tool = parent.selectedTool
                canvasView.isDrawingEnabled = parent.isDrawingEnabled
                canvasView.backgroundColor = .clear
                canvasView.drawingPolicy = .default
                canvasView.overrideUserInterfaceStyle = .light   // Prevent ink colour from being changed
                pageToViewMapping[page] = canvasView
                resultView = canvasView
            }
            
            
            if let page = page as? PNPDFPage,
               let drawing = page.drawing {
                resultView?.drawing = drawing
            }
            return resultView
        }
        
        func pdfView(_ pdfView: PDFView, willEndDisplayingOverlayView overlayView: UIView, for page: PDFPage) {
            if let overlayView = overlayView as? PKCanvasView,
               let page = page as? PNPDFPage {
                page.drawing = overlayView.drawing
                pageToViewMapping.removeValue(forKey: page)
            }
        }
    }
}
