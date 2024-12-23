//
//  PreviewManager.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-21.
//

import PDFKit
import UIKit

class PreviewManager {
    
    /// Convert a page from the provided PDF document into a `UIImage`. This can be used to export existing PDF in Power Notes into external images for sharing, or use in app for displaying thumbnails for documents and templates.
    /// - Parameters:
    ///   - document: The PDF document to get a page from
    ///   - pageIndex: The page index to get from the document
    ///   - imageSize: The size of the resulting image
    /// - Returns: A `UIImage` object that contains the data of the converted PDF page.
    public static func convertPDFToImage(document: PDFDocument, pageIndex: Int, imageSize: CGSize? = nil) -> UIImage? {
        guard let page = document.page(at: pageIndex) else {
            print("Invalid page index")
            return nil
        }
        
        // Get the size of the page
        let pageRect = page.bounds(for: .mediaBox)
        
        // Use custom size if provided, otherwise use the original size
        let renderSize = imageSize ?? pageRect.size
        let scaleFactorX = renderSize.width / pageRect.width
        let scaleFactorY = renderSize.height / pageRect.height
        
        // Create a graphics context for rendering
        UIGraphicsBeginImageContextWithOptions(renderSize, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            print("Failed to create graphics context")
            return nil
        }
        
        // Fill the background white (because the website I got the templates from doesn't seem to simulates the background colour
        UIColor.white.setFill()
        context.fill(CGRect(origin: .zero, size: renderSize))
        
        // Flip the context vertically (PDF coordinate system is flipped)
        context.saveGState()
        context.translateBy(x: 0, y: renderSize.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        // Scale the page to fit the desired image size
        context.scaleBy(x: scaleFactorX, y: scaleFactorY)
        
        // Render the page into the context
        page.draw(with: .mediaBox, to: context)
        context.restoreGState()
        
        // Capture the resulting image
        let renderedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return renderedImage
    }
}
