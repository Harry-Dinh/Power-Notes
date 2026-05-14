//
//  PNNote.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-13.
//

import Foundation
import SwiftData
import PDFKit

@Model
final class PNNote {
    @Attribute(.unique) var id: UUID
    var name: String
    
    var pdfData: Data?
    @Transient var pdfDocument: PDFDocument? {
        get {
            guard let pdfData,
                  let pdfDocument = PDFDocument(data: pdfData) else {
                return nil
            }
            return pdfDocument
        }
        set {
            pdfData = newValue?.dataRepresentation()
        }
    }
    
    var markdownText: String?
    
    var createdOn: Date?
    var lastEdited: Date?
    
    init(
        id: UUID = UUID(),
        name: String,
        pdfDocument: PDFDocument? = nil,
        markdownText: String? = nil,
        createdOn: Date? = nil,
        lastEdited: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.pdfDocument = pdfDocument
        self.markdownText = markdownText
        self.createdOn = createdOn
        self.lastEdited = lastEdited
    }
    
    static let placeholder = PNNote(
        id: UUID(),
        name: "The Final Frontier",
        pdfDocument: nil,
        markdownText:
            """
Space: The final frontier. These are the voyages of the *starship Enterprise*.
Its continuing mission: **To explore strange new worlds. To seek out new life, and new civilizations.**
#To boldly go where no one has gone before!
""",
        createdOn: Date(),
        lastEdited: nil
    )
}
