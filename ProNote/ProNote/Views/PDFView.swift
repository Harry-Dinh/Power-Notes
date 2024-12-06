//
//  PDFView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-06.
//

import Foundation
import PDFKit
import PencilKit

class PDFWithAnnotationsVC: UIViewController, PKCanvasViewDelegate {
    let pdfURL: URL
    var pdfView: PDFView!
    var canvasView: PKCanvasView!
    
    init(pdfURL: URL) {
        self.pdfURL = pdfURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and configure PDFView
        pdfView = PDFView(frame: view.bounds)
        pdfView.autoScales = true
        if let document = PDFDocument(url: pdfURL) {
            pdfView.document = document
        }
        view.addSubview(pdfView)
        
        // Create and configure PKCanvasView
        canvasView = PKCanvasView(frame: view.bounds)
        canvasView.backgroundColor = .clear
        canvasView.isOpaque = false
        canvasView.delegate = self
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 3)
        canvasView.drawingPolicy = .anyInput
        view.addSubview(canvasView)
        
        // Keep canvasView in sync with pdfView for zoom and scroll
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            canvasView.leadingAnchor.constraint(equalTo: pdfView.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: pdfView.trailingAnchor),
            canvasView.topAnchor.constraint(equalTo: pdfView.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: pdfView.bottomAnchor),
        ])
    }
}
