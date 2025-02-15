//
//  MainEditVM.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import SwiftUI
import PDFKit

/// The view model for the `MainEditView` struct.
@Observable
class MainEditVM {
    
    // MARK: Singleton Instance
    
    /// The singleton instance of the `MainEditVM` class.
    public static let instance = MainEditVM()
    
    // MARK: - Properties
    
    public var openPageOverview = false
    public var currentNotebook = PNNotebookWrapper(nil)
    public var showMarkupToolbar = true
    public var documentViewOffsetAmount: CGFloat = 50
    public var showTemplatePicker = false
    public var pageCount = 0
    public var currentDocumentWrapper = PDFDocumentWrapper(nil)     // This will be assigned with a document before the view loads
    public var pdfView: PDFView = PDFView()
    public var userFountainPenColorPalette: [Color] = []
    public var userHighlighterColorPalette: [Color] = []
    public var userPencilToolColorPalette: [Color] = []
    
    // MARK: - Public Functions
    
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
        print("preloadNotebookThumbnails() called")
        guard var currentNotebook = currentNotebook.notebook,
              let document = currentNotebook.document else {
            fatalError("Failed to unwrap notebook and/or document")
        }
        
        // Remove all previous thumbnails from last fetch session
        // This might be extremely inefficient...
        if document.pageCount > 0 {
            print("Removed all thumbnails to prepare for refill")
            currentNotebook.thumbnails.removeAll()
        }
        
        for i in 0..<document.pageCount {
            guard let thumbnail = PreviewManager.convertPDFToImage(document: document, pageIndex: i) else {
                continue
            }
            currentNotebook.thumbnails.append(thumbnail)
        }
    }
    
    public func saveUserColorPalettes() {
        // Convert the colors in each palette to an array of hex strings
        let fountainPenHex = convertToHexArray(userFountainPenColorPalette)
        let highlighterHex = convertToHexArray(userHighlighterColorPalette)
        let pencilToolHex = convertToHexArray(userPencilToolColorPalette)
        
        // Save the hex palettes to local storage
        PNConstants.USER_DEFAULT.set(fountainPenHex, forKey: UDKeys.FOUNTAIN_PEN_PALETTE)
        PNConstants.USER_DEFAULT.set(highlighterHex, forKey: UDKeys.HIGHLIGHTER_PALETTE)
        PNConstants.USER_DEFAULT.set(pencilToolHex, forKey: UDKeys.PENCIL_PALETTE)
    }
    
    public func loadUserColorPalettes() {
        // Retrieve and unwrap the color palettes from UserDefaults
        guard let fountainPenHex = PNConstants.USER_DEFAULT.array(forKey: UDKeys.FOUNTAIN_PEN_PALETTE) as? [String],
              let highlighterHex = PNConstants.USER_DEFAULT.array(forKey: UDKeys.HIGHLIGHTER_PALETTE) as? [String],
              let pencilToolHex = PNConstants.USER_DEFAULT.array(forKey: UDKeys.PENCIL_PALETTE) as? [String] else {
            print("Unable to unwrap any of the hex arrays for the tool color palette")
            return
        }
        
        // Unwrap the color arrays
        guard let fountainPalette = convertToColorArray(fountainPenHex),
              let highlighterPalette = convertToColorArray(highlighterHex),
              let pencilPalette = convertToColorArray(pencilToolHex) else {
            print("Unable to convert hex arrays into color palettes")
            return
        }
        
        // Assign the color palettes to the respective properties
        userFountainPenColorPalette = fountainPalette
        userHighlighterColorPalette = highlighterPalette
        userPencilToolColorPalette = pencilPalette
    }
    
    // MARK: - Private Functions
    
    private func convertToHexArray(_ palette: [Color]) -> [String]? {
        // Exit early if the provided color palette is empty
        if palette.isEmpty { return nil }
        
        // Proceed to convert colors to hex codes
        var hexCodes: [String] = []
        for color in palette {
            guard let hex = color.toHex() else {        // Attempt to unwrap the hex code
                continue                                // Continue to the next color if previous one can't be unwrapped
            }
            hexCodes.append(hex)                        // Append hex code to array
        }
        return hexCodes
    }
    
    private func convertToColorArray(_ hexCodes: [String]) -> [Color]? {
        if hexCodes.isEmpty { return nil }
        
        // Proceed to convert to Color
        var colorArray: [Color] = []
        for hexCode in hexCodes {
            guard let color = Color(hex: hexCode) else {
                continue
            }
            colorArray.append(color)
        }
        return colorArray
    }
}
