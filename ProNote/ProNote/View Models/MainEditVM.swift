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
    
    public var openPageOverview = NavigationSplitViewVisibility.detailOnly
    
    public var currentNotebook = PNNotebookWrapper(nil)
    public var showMarkupToolbar = true
    public var documentViewOffsetAmount: CGFloat = 50
    public var showTemplatePicker = false
    public var pageCount = 0
    public var currentDocumentWrapper = PDFDocumentWrapper(nil)     // This will be with a document before the view loads
    public var pdfView: PDFView = PDFView()
    
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
        // Unwrap notebook and document
        guard var notebook = currentNotebook.notebook,
              let document = notebook.document else {
            fatalError("Unable to unwrap notebook and/or document")
        }
        
        // Remove all thumbnails from the previous fetch session
        if document.pageCount > 0 {
            notebook.thumbnails.removeAll()
        }
        
        // Convert and append new thumbnails
        for i in 0..<document.pageCount {
            guard let page = document.page(at: i),
                  let thumbnail = PreviewManager.pdfPageToImage(pdfPage: page) else {
                continue
            }
            notebook.thumbnails.append(thumbnail)
        }
    }
}
