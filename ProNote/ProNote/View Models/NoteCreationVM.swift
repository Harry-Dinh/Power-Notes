//
//  NoteCreationVM.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-16.
//

import PDFKit
import SwiftUI

@Observable
class NoteCreationVM {
    public static let instance = NoteCreationVM()
    
    public var openNotebook = false
    public var addCoverToggle = false
    public var paperSizePickerOption = 0
    public var selectedTemplate: UIImage?
    public var selectedTemplateIndex: Int?
    public var selectedCover: UIImage?
    public var selectedCoverIndex: Int?
    
    public var notebookName = "Untitled Notebook"
    
    public func createNotebook() -> PNNotebook? {
        print("NoteCreationVM.createNotebook() called")
        if notebookName.isEmpty {
            print("Notebook name is empty, unable to create notebook object!")
            return PNNotebook.PLACEHOLDER
        }
        
        // Get the singleton of the PrimaryVM and NoteCreationVM
        let primaryVM = PrimaryVM.instance
        let noteCreationVM = NoteCreationVM.instance
        
        // Get the URL for the writing page (and cover if user selected to add)
        let pageTemplateURL = getTemplateURL(for: .writingPage)
        var coverTemplateURL: URL? = nil
        if noteCreationVM.addCoverToggle {
            coverTemplateURL = getTemplateURL(for: .frontCover)
        }
        
        // Creating a PDF document for each of the URL above
        guard let pageURL = pageTemplateURL else {
            fatalError("Unable to unwrap templates URLs, cannot continue")
        }
        let pageDoc = PDFDocument(url: pageURL)
        var coverDoc: PDFDocument?
        if noteCreationVM.addCoverToggle {
            guard let coverURL = coverTemplateURL else {
                return nil
            }
            coverDoc = PDFDocument(url: coverURL)
        }
        
        // Merge these two documents together (if cover is present)
        var finalDoc: PDFDocument
        if noteCreationVM.addCoverToggle {
            guard let destination = coverDoc,
                  let source = pageDoc else {
                fatalError("Unable to unwrap coverDoc and pageDoc, cannot continue")
            }
            finalDoc = mergePDFs(destination: destination, source: source)
        } else {
            guard let pageDoc = pageDoc else {
                fatalError("Unable to unwrap pageDoc, cannot continue")
            }
            finalDoc = pageDoc
        }
        
        // Create a new PNNotebook object then assign the PDF document to it
        var newNotebook = PNNotebook(notebookName)
        newNotebook.document = finalDoc
        
        // Convert all pages in the newly created notebook to an image
        for i in 0..<finalDoc.pageCount {
            guard let page = finalDoc.page(at: i),
                  let thumbnail = PreviewManager.pdfPageToImage(pdfPage: page) else {
                continue
            }
            newNotebook.thumbnails.append(thumbnail)
        }
        
        // Append the new PNNotebook to the notebook array
        primaryVM.homeFolder.notebooks.append(newNotebook)
        print("NoteCreationVM.createNotebook() completed")
        return newNotebook
    }
    
    public func createQuickNote() -> PNNotebook {
        let primaryVM = PrimaryVM.instance
        let templateURL = primaryVM.templateURLs[1]
        let blankPageDoc = PDFDocument(url: templateURL)
        var newQuickNote = PNNotebook("New Quick Note")
        newQuickNote.document = blankPageDoc
        
        // Append the first page into the thumbnail array
        guard let doc = blankPageDoc,
              let firstPage = doc.page(at: 0),
              let thumbnail = PreviewManager.pdfPageToImage(pdfPage: firstPage) else {
            fatalError("Unable to convert first page to image, cannot proceed")
        }
        
        newQuickNote.thumbnails.append(thumbnail)
        primaryVM.homeFolder.notebooks.append(newQuickNote)
        return newQuickNote
    }
    
    private func getTemplateURL(for pageType: TemplateType) -> URL? {
        print("NoteCreationVM.getTemplateURL() called")
        let primaryVM = PrimaryVM.instance
        let noteCreationVM = NoteCreationVM.instance
        
        if pageType == .frontCover {
            guard let coverIndex = noteCreationVM.selectedCoverIndex else {
                fatalError("Cannot unwrap cover index, cannot continue")
            }
            
            print("Returning cover URL, NoteCreationVM.getTemplateURL() completed")
            return primaryVM.coverTemplateURLs[coverIndex]
        }
        
        guard let templateIndex = noteCreationVM.selectedTemplateIndex else {
            fatalError("Cannot unwrap template index, cannot continue")
        }
        
        print("Returning template URL, NoteCreationVM.getTemplateURL() completed")
        return primaryVM.templateURLs[templateIndex]
    }
    
    public func mergePDFs(destination: PDFDocument, source: PDFDocument) -> PDFDocument {
        print("NoteCreationVM.mergePDFs() called")
        for i in 0..<source.pageCount {
            if let page = source.page(at: i) {
                destination.insert(page, at: destination.pageCount)
            }
        }
        
        print("NoteCreationVM.mergePDFs() completed")
        return destination
    }
}
