//
//  PNFolder.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-13.
//

import Foundation
import SwiftData

@Model
final class PNFolder {
    @Attribute(.unique) var id: UUID
    @Attribute(.unique) var name: String
    @Relationship(deleteRule: .cascade) var subfolders: [PNFolder]?
    @Relationship(deleteRule: .cascade) var notes: [PNNote]?
    
    init(
        id: UUID = UUID(),
        name: String,
        subfolders: [PNFolder]? = nil,
        notes: [PNNote]? = nil
    ) {
        self.id = id
        self.name = name
        self.subfolders = subfolders
        self.notes = notes
    }
    
    static let placeholder = PNFolder(name: "Class Notes")
}
