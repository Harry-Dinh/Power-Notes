//
//  PDFGenerationManager.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-31.
//

import PDFKit
import CoreGraphics

class PDFGenerationManager {
    static let shared = PDFGenerationManager()
    
    func makeGraphPaperPDF() async -> PDFDocument? {
        let data = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(
            data,
            CGRect(origin: .zero, size: Constants.letterSizePortraitPaper),
            nil
        )
        
        UIGraphicsBeginPDFPage()
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        drawGrid(
            in: context,
            pageSize: Constants.letterSizePortraitPaper,
            spacing: 20
        )
        
        UIGraphicsEndPDFContext()
        
        guard let finalPDFDocument = PDFDocument(data: data as Data) else {
            return nil
        }
        return finalPDFDocument
    }
    
    private func drawGrid(
        in context: CGContext,
        pageSize: CGSize,
        spacing: CGFloat,
        lineWidth: CGFloat = 0.25
    ) {
        context.saveGState()
        context.setLineWidth(lineWidth)
        
        // Draw vertical lines
        for x in stride(from: 0.0, to: pageSize.width, by: spacing) {
            context.move(to: CGPoint(x: x, y: 0))
            context.addLine(to: CGPoint(x: x, y: pageSize.height))
        }
        
        // Draw horizontal lines
        for y in stride(from: 0.0, to: pageSize.height, by: spacing) {
            context.move(to: CGPoint(x: 0, y: y))
            context.addLine(to: CGPoint(x: pageSize.width, y: y))
        }
        
        context.strokePath()
        context.restoreGState()
    }
}
