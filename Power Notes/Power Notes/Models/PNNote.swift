//
//  PNNote.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-13.
//

import Foundation
import SwiftData
import PaperKit

@Model
final class PNNote {
    @Attribute(.unique) var id: UUID
    var name: String
    var paperMarkup: PaperMarkup?
    var markdownText: String?
    var createdOn: Date?
    var lastEdited: Date?
    
    init(
        id: UUID = UUID(),
        name: String,
        paperMarkup: PaperMarkup? = nil,
        markdownText: String? = nil,
        createdOn: Date? = nil,
        lastEdited: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.paperMarkup = paperMarkup
        self.markdownText = markdownText
        self.createdOn = createdOn
        self.lastEdited = lastEdited
    }
    
    static let placeholder = PNNote(
        id: UUID(),
        name: "The Final Frontier",
        paperMarkup: nil,
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
