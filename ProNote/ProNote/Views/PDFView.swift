//
//  PDFView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-06.
//

import Foundation
import PDFKit
import PencilKit

class PDFRenderer: UIViewController, PDFViewDelegate {
    let document: PDFDocument?
    var pdfView: PDFView!
    
    init(document: PDFDocument?) {
        self.document = document
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        pdfView = PDFView(frame: view.bounds)
        pdfView.delegate = self
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.displaysPageBreaks = true
        pdfView.document = document
        pdfView.usePageViewController(false)
        
        view.addSubview(pdfView)
    }
}
