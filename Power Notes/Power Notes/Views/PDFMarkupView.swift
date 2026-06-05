//
//  PDFMarkupView.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-31.
//

import SwiftUI
import PDFKit

struct PDFMarkupView: UIViewRepresentable {
    @Binding var note: PNNote
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = note.pdfDocument
        pdfView.backgroundColor = .secondarySystemBackground
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {}
}
