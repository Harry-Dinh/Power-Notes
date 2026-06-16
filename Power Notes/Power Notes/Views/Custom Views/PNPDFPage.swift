//
//  PNPDFPage.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-06-06.
//

import PDFKit
import PencilKit

final class PNPDFPage: PDFPage {
    var drawing: PKDrawing?
    
    init(drawingData: Data) {
        super.init()
        self.drawing = try? PKDrawing(data: drawingData)
    }
}
