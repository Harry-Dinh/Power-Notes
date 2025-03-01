//
//  PreviewManager.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-21.
//

import PDFKit
import UIKit

/// A class containing (mostly) static methods that are used to convert PDFs to images and vice versa.
class PreviewManager {
    
    // TODO: Need to modify these functions to include the user annotation on the PDF!
    
    /// Convert a page from the provided PDF document into a `UIImage`. This can be used to export existing PDF in Power Notes into external images for sharing, or use in app for displaying thumbnails for documents and templates.
    /// - Parameters:
    ///   - document: The PDF document to get a page from
    ///   - pageIndex: The page index to get from the document
    ///   - imageSize: The size of the resulting image
    /// - Returns: A `UIImage` object that contains the data of the converted PDF page.
    public static func pdfDocumentToImage(document: PDFDocument, pageIndex: Int, imageSize: CGSize? = nil) -> UIImage? {
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
    
    /// Convert a given `PDFPage` to a `UIImage`
    /// - Parameters:
    ///   - pdfPage: The page to convert
    ///   - scale: The scale factor of the page. `2.0` by default to look sharp on Retina displays
    /// - Returns: An image of the provided page
    public static func pdfPageToImage(pdfPage: PDFPage, scale: CGFloat = 2.0) -> UIImage? {
        print("pdfPageToImage() called")
        // Get the page bounds
        let pageRect = pdfPage.bounds(for: .mediaBox)
        
        // Create a render format that scales the image
        let scaledPageRect = CGRect(x: 0, y: 0, width: pageRect.width * scale, height: pageRect.height * scale)
        
        // Create a bitmap-based graphics context
        UIGraphicsBeginImageContext(scaledPageRect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        // Set the scale factor to the context
        context.scaleBy(x: scale, y: scale)
        
        // Fill the background with white colour
        context.setFillColor(UIColor.white.cgColor)
        context.fill(scaledPageRect)
        
        // Draw the PDF page into the context
        context.saveGState()
        context.translateBy(x: 0.0, y: scaledPageRect.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.drawPDFPage(pdfPage.pageRef!)
        context.restoreGState()
        
        // Get the resulting image from the context
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
