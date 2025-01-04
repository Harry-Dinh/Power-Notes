//
//  MainEditVM.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import SwiftUI
import PDFKit

@Observable
class MainEditVM {
    
    public static let instance = MainEditVM()
    
    public var openPageOverview = false
    
    public var currentNotebook = PNNotebookWrapper(nil)
    public var showMarkupToolbar = true
    public var documentViewOffsetAmount: CGFloat = 50
    public var showTemplatePicker = false
    public var pageCount = 0
    public var currentDocumentWrapper = PDFDocumentWrapper(nil)     // This will be with a document before the view loads
    
    public func quicklyInsertPageAtEnd() {
        guard let document = currentDocumentWrapper.document,
              let latestPageTemplate = document.page(at: document.pageCount - 1),
              var currentNotebook = currentNotebook.notebook else {
            fatalError("Unable to unwrap document and/or latest page template, cannot continue")
        }
        
        if let newPage = latestPageTemplate.copy() as? PDFPage {
            document.insert(newPage, at: document.pageCount)
            currentNotebook.document = document
            
            // Convert the latest page to an image
            guard let thumbnailImage = PreviewManager.pdfPageToImage(pdfPage: newPage) else {
                print("Failed to convert thumbnail to image")
                return
            }
            
            currentNotebook.thumbnails.append(thumbnailImage)
        }
    }
    
    public func preloadNotebookThumbnails() {
        print("preloadNotebookThumbnails() called")
        guard var currentNotebook = currentNotebook.notebook,
              let document = currentNotebook.document else {
            fatalError("Failed to unwrap notebook and/or document")
        }
        
        // Remove all previous thumbnails from last fetch session
        // This might be extremely inefficient...
        if document.pageCount > 0 {
            print("Removed all thumbnails to prepare for refill")
            currentNotebook.thumbnails.removeAll()
        }
        
        for i in 0..<document.pageCount {
            guard let thumbnail = PreviewManager.convertPDFToImage(document: document, pageIndex: i) else {
                continue
            }
            currentNotebook.thumbnails.append(thumbnail)
        }
    }
}
