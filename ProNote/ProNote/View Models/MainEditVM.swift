//
//  MainEditVM.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import SwiftUI
import PDFKit

/// The view model for the `MainEditView` and is subviews.
@Observable
class MainEditVM {
    
    /// The singleton instance of the `MainEditVM` class.
    public static let instance = MainEditVM()
    
    /// Hold the current state of the sidebar visibility (hidden by default.)
    public var sidebarVisibility = NavigationSplitViewVisibility.detailOnly
    
    /// The notebook (wrapper) that is used to work in this view. **This has to have a value otherwise will result in a crash!**
    public var currentNotebook = PNNotebookWrapper(nil)             // This will be assigned with a wrapper with a notebook inside when the view loads
    
    /// A boolean that shows/hides the custom tool picker. This is toggled by the Markup button on the top right of the toolbar.
    public var showMarkupToolbar = true
    public var documentViewOffsetAmount: CGFloat = 50
    
    /// A boolean that shows/hide the template picker for when adding a new page with a specific template.
    public var showTemplatePicker = false
    
    /// The number of pages in this current document **(Might be deprecated in the near future...)**
    public var pageCount = 0
    
    /// The current page that the user is viewing (page index + 1)
    public var currentPage = 0
    
    /// The document (wrapper) for the current `PDFDocument` **(Might be deprecated in the near future...)**
    public var currentDocumentWrapper = PDFDocumentWrapper(nil)     // This will be assigned with a document before the view loads
    
    /// The `PDFView` for rendering the current notebook's document.
    public var pdfView: PDFView = PDFView()
    
    /// This function appends a new page at the end of the document using the same template as the previous page. This function is called when the user taps the "Add Page" button at the top of the toolbar.
    public func quicklyInsertPageAtEnd() {
        guard var currentNotebook = currentNotebook.notebook,
              let document = currentNotebook.document,
              let latestPageTemplate = document.page(at: document.pageCount - 1) else {
            fatalError("Unable to unwrap notebook and/or its document. Unable to continue.")
        }
        
        if let newPage = latestPageTemplate.copy() as? PDFPage {
            document.insert(newPage, at: document.pageCount)
            currentNotebook.document = document
            
            // Convert the latest page to an image
            guard let thumbnailImage = PreviewManager.pdfDocumentToImage(document: document, pageIndex: document.pageCount - 1) else {
                print("Failed to convert thumbnail to image")
                return
            }
            currentNotebook.thumbnails.append(thumbnailImage)
            self.currentNotebook.notebook = currentNotebook
        }
    }
    
    /// Preload the thumbnail of the member `currentNotebook` when the `MainEditView` is initializing.
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
            guard let thumbnail = PreviewManager.pdfDocumentToImage(document: document, pageIndex: i) else {
                continue
            }
            notebook.thumbnails.append(thumbnail)
        }
    }
}
