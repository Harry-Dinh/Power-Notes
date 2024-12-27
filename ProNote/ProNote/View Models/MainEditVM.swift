//
//  MainEditVM.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import SwiftUI

@Observable
class MainEditVM {
    
    public static let instance = MainEditVM()
    
    public var currentNotebook: PNNotebook?
    public var showMarkupToolbar = true
    public var documentViewOffsetAmount: CGFloat = 50
    public var showTemplatePicker = false
    public var pageCount = 0
    public var currentDocumentWrapper = PDFDocumentWrapper(nil)     // This will be with a document before the view loads
    
    // TODO: This function works but the view doesn't update along with it...
    public func quicklyInsertPageAtEnd() {
        guard let currentNotebook = currentNotebook,
              let document = currentNotebook.document,
              let latestPageTemplate = document.page(at: document.pageCount - 1) else {
            fatalError("Cannot unwrap notebook and/or document")
        }
        document.insert(latestPageTemplate, at: document.pageCount)
    }
}
