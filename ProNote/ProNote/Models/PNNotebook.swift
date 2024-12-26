//
//  PNNotebook.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-16.
//

import PDFKit
import PencilKit

/// An object that represent a virtual notebook that the user can create and edit.
struct PNNotebook: Identifiable {
    
    /// The unique identifier of this notebook (required for conforming to Swift's `Identifiable` protocol
    var id: String
    
    /// The human-readable name of this notebook
    var name: String
    
    /// The date and time that this notebook was created
    var dateCreated: Date
    
    /// The date and time that this notebook was last edited
    var lastEdited: Date
    
    /// The PDF document associated with this notebook
    var document: PDFDocument?
    
    /// The annotation created by the user in this notebook
    var userAnnotation: PKDrawing?
    
    /// A boolean keeps track of if the notebook is bookmarked or not
    var isBookmarked: Bool
    
    init() {
        self.id = UUID().uuidString
        self.name = "Untitled Notebook"
        self.dateCreated = Date()
        self.lastEdited = Date()
        self.document = nil
        self.userAnnotation = nil
        self.isBookmarked = false
    }
    
    init(_ name: String) {
        self.id = UUID().uuidString
        self.name = name
        self.dateCreated = Date()
        self.lastEdited = Date()
        self.document = nil
        self.userAnnotation = nil
        self.isBookmarked = false
    }
    
    init(_ id: String, _ name: String, _ dateCreated: Date, _ lastEdited: Date, _ document: PDFDocument?, _ userAnnotation: PKDrawing?, _ isBookmarked: Bool) {
        self.id = id
        self.name = name
        self.dateCreated = dateCreated
        self.lastEdited = lastEdited
        self.document = document
        self.userAnnotation = userAnnotation
        self.isBookmarked = isBookmarked
    }
    
    public static let PLACEHOLDER = PNNotebook("NX-93581", "Debug Notebook", Date(), Date(), nil, nil, false)
}
