//
//  PDFView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-06.
//

import Foundation
import PDFKit
import PencilKit

class PDFRenderer: UIViewController, PDFViewDelegate, PKCanvasViewDelegate {
    let pdfURL: URL
    var pdfView: PDFView!
    var canvases: [PKCanvasView] = []
    var toolPicker: PKToolPicker!
    var isExistingNotebook: Bool
    var isDrawingEnabled: Bool = true {
        didSet {
            for canvas in canvases {
                canvas.isUserInteractionEnabled = isDrawingEnabled
            }
            onDrawingModeChanged?(isDrawingEnabled)
        }
    }
    
    var onDrawingModeChanged: ((Bool) -> Void)?
    
    init(pdfURL: URL, isExistingNotebook: Bool) {
        self.pdfURL = pdfURL
        self.isExistingNotebook = isExistingNotebook
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        // MARK: Set up the PDF view
        pdfView = PDFView(frame: view.bounds)
        pdfView.delegate = self
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.displaysPageBreaks = true
        pdfView.usePageViewController(false)
        
        // Assign a PDF document to the view
        if let document = PDFDocument(url: pdfURL) {
            pdfView.document = document
        }
        view.addSubview(pdfView)
        
        // Set up the tool picker (might want to swap this out later for a custom one...)
        toolPicker = PKToolPicker()
        toolPicker.setVisible(true, forFirstResponder: self.view)
        
        // Overlay each PDF page with a canvas view
        alignCanvasesWithPDF()
        
        // Ensure layout updates when view bounds change
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateCanvasViewFrames),
                                               name: .PDFViewPageChanged,
                                               object: pdfView)
    }
    
    private func alignCanvasesWithPDF() {
        guard let document = pdfView.document else { return }
        
        for i in 0..<document.pageCount {
            guard let page = document.page(at: i) else { continue }
            let pageBounds = page.bounds(for: .mediaBox)
            let convertedBounds = pdfView.convert(pageBounds, from: page)
            
            // Create a canvas view with the same size as the converted bounds
            let canvasView = PKCanvasView(frame: convertedBounds)
            canvasView.backgroundColor = .clear
            canvasView.isOpaque = false
            canvasView.tool = PKInkingTool(.pen, color: .black, width: 5)
            canvasView.isScrollEnabled = false
            
            // Add the canvas view as a subview to the PDFView
            pdfView.addSubview(canvasView)
            canvases.append(canvasView)
            
            // Add the canvas view to the tool picker
            toolPicker.addObserver(canvasView)
            canvasView.becomeFirstResponder()
        }
    }
    
    @objc func updateCanvasViewFrames() {
        guard let document = pdfView.document else { return }
        
        for (index, canvasView) in canvases.enumerated() {
            guard let page = document.page(at: index) else { continue }
            
            // Get the page's bounds in the PDFView's coordinate space
            let pageBounds = page.bounds(for: .mediaBox)
            let convertedBounds = pdfView.convert(pageBounds, from: page)
            
            // Update the frame of the canvas view
            canvasView.frame = convertedBounds
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateCanvasViewFrames()
    }
    
    public func setDrawingMode(isDrawingEnabled: Bool) {
        self.isDrawingEnabled = isDrawingEnabled
    }
    
    private func setupGestureHandling() {
        // Enable canvas view to detect touches but also allow scrolling
        for canvas in canvases {
            canvas.drawingPolicy = .pencilOnly  // Only use the Apple Pencil for drawing
            let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                              action: #selector(handlePanGesture(_:)))
            panGestureRecognizer.delegate = self
            canvas.addGestureRecognizer(panGestureRecognizer)
        }
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let scrollView = findScrollView(in: pdfView) else { return }
        if isDrawingEnabled {
            // Allow scrolling if the gesture is not recongized as drawing
            scrollView.panGestureRecognizer.require(toFail: gesture)
        }
    }
    
    private func findScrollView(in pdfView: PDFView) -> UIScrollView? {
        for subview in pdfView.subviews {
            if let scrollView = subview as? UIScrollView {
                return scrollView
            } else if let nestedScrollView = findScrollView(in: subview as! PDFView) {  // TODO: Some recursion here, check this if the app gives you an infinite loop...
                return nestedScrollView
            }
        }
        return nil
    }
}

extension PDFRenderer: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
