//
//  PDFView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-06.
//

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
        // MARK: - Configure the PDF view
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Detect a change in orientation and update the view to fill the screen accordingly
        print("Orientation changed")
        updateViewFrame()
    }
    
    /// Update the frame of the PDF view when the orientation of the device changes to make sure the view fills the screen instead of retaining the size of the previous orientation
    func updateViewFrame() {
        // Basically reassign the value to match with the viewport's size
        // TODO: - FIX THIS LATER! -
        var pdfFrame: CGRect = pdfView.frame
        let viewFrame: CGRect = view.frame
        pdfFrame.origin = viewFrame.origin
        pdfFrame.size.width = viewFrame.width
        pdfFrame.size.height = viewFrame.height
        pdfView.frame = pdfFrame
    }
}
