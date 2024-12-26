//
//  PDFDocumentWrapper.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-25.
//

import PDFKit
import SwiftUI

@Observable
class PDFDocumentWrapper {
    let document: PDFDocument?
    
    init(_ document: PDFDocument?) {
        self.document = document
    }
}
