//
//  PDFGenerationManager.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-31.
//

import PDFKit
import CoreGraphics
import SwiftUI

class PDFGenerationManager {
    static let shared = PDFGenerationManager()
    
    func createWritingPaperPDF(
        for paperType: PNWritingPaperTypes,
        colors: [Color]
    ) async -> PDFDocument? {
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
        
        setBackgroundColor(
            for: context,
            with: colors[0],
            of: Constants.letterSizePortraitPaper
        )
        
        if paperType != .blank {
            drawLineOnTemplate(
                for: paperType == .lined ? .horizontal : .bothDirections,
                lineColor: colors[1],
                in: context,
                pageSize: Constants.letterSizePortraitPaper,
                spacing: 20     // TODO: Replace this with a picker
            )
        }
        
        UIGraphicsEndPDFContext()
        
        guard let finalPDFDocument = PDFDocument(data: data as Data) else {
            return nil
        }
        return finalPDFDocument
    }
    
    private func setBackgroundColor(for context: CGContext, with color: Color, of size: CGSize) {
        context.saveGState()
        
        let uiColor = UIColor(color)
        let cgColor = uiColor.cgColor
        context.setFillColor(cgColor)
        context.fill([CGRect(origin: CGPoint(x: 0, y: 0), size: size)])
        
        context.fillPath()
        context.restoreGState()
    }
    
    private func drawLineOnTemplate(
        for direction: PNNoteTemplateDrawingDirection,
        lineColor: Color,
        in context: CGContext,
        pageSize: CGSize,
        spacing: CGFloat,
        lineWidth: CGFloat = 0.25
    ) {
        context.saveGState()
        context.setLineWidth(lineWidth)
        
        let uiColor = UIColor(lineColor)
        let cgColor = uiColor.cgColor
        context.setStrokeColor(cgColor)
        
        // Draw vertical lines
        if direction == .vertical || direction == .bothDirections {
            for x in stride(from: 0.0, to: pageSize.width, by: spacing) {
                context.move(to: CGPoint(x: x, y: 0))
                context.addLine(to: CGPoint(x: x, y: pageSize.height))
            }
        }
        
        // Draw horizontal lines
        if direction == .horizontal || direction == .bothDirections {
            for y in stride(from: 0.0, to: pageSize.height, by: spacing) {
                context.move(to: CGPoint(x: 0, y: y))
                context.addLine(to: CGPoint(x: pageSize.width, y: y))
            }
        }
        
        context.strokePath()
        context.restoreGState()
    }
}
