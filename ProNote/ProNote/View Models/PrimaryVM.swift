//
//  PrimaryVM.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import PDFKit
import SwiftUI

@Observable
class PrimaryVM {
    
    // MARK: - General Variables
    public static let instance = PrimaryVM()
    public var templateURLs: [URL] = []
    public var templatesThumbnails: [UIImage] = []
    
    // MARK: - SwiftUI States
    public var showNotebookCreationView = false
    
    // MARK: - Shared Variables
    public var currentUser = PNUser.PLACEHOLDER
    public var homeFolder = PNFolder("Home")
    
    // MARK: - Functions
    
    /// Preload the member `templateURLs` array with the URL of all of the PDF templates. This function should be called whenever the app launches.
    public func preloadTemplatesURL() {
        print("Templates preload starting -- PrimaryVM.preloadTemplatesURL() called")
        
        // Get the path to the templates directory
        guard let directoryPath = Bundle.main.path(forResource: "Templates", ofType: nil) else {
            print("Cannot locate directory in local scope\nTemplates preload failed")
            return
        }
        
        print("Templates directory path: \(directoryPath)")
        
        // Get a reference to that directory using the given path
        let directory: [String]
        do {
            directory = try FileManager.default.contentsOfDirectory(atPath: directoryPath)
        } catch {
            print("Invalid directory, cannot proceed\nTemplates preload failed")
            return
        }
        
        // Map the data from the fetched directory into the member templatesURLs array
        templateURLs = directory.map { fileName in
            URL(fileURLWithPath: directoryPath).appending(path: fileName)   // Hopefully this is the URL PDFKit is looking for...
        }
        
        print("Templates preload completed")
    }
    
    /// Bulk convert all PDF files in the Templates directory into thumbnail images. Call this function when the app first launch, right after `preloadTemplateURL()`.
    public func convertPDFToThumbnailImages() {
        if templateURLs.isEmpty {
            print("URL array is empty, cannot proceed")
            return
        }
        
        for url in templateURLs {
            guard let document = PDFDocument(url: url),
                  let convertedImage = PreviewManager.convertPDFToImage(document: document, pageIndex: 0) else {
                print("Cannot convert document to image")
                return
            }
            templatesThumbnails.append(convertedImage)
        }
    }
}
