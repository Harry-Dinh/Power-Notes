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
    @Attribute(.unique) var uuid: UUID
    
    @Attribute(.unique) var name: String
    
    @Relationship(deleteRule: .cascade) var subfolders: [PNFolder]?
    
    @Relationship(deleteRule: .cascade, inverse: \PNNote.parentFolder)
    var notes: [PNNote]?
    
    @Transient var subfoldersCount: Int {
        guard let subfolders else { return 0 }
        return subfolders.count
    }
    
    @Transient var noteCount: Int {
        guard let notes else { return 0 }
        return notes.count
    }
    
    @Transient var isInboxFolder: Bool {
        return uuid == Constants.inboxFolderUUID
    }
    
    init(
        uuid: UUID = UUID(),
        name: String,
        subfolders: [PNFolder]? = nil,
        notes: [PNNote]? = nil
    ) {
        self.uuid = uuid
        self.name = name
        self.subfolders = subfolders
        self.notes = notes
    }
    
    static let placeholder = PNFolder(name: "Class Notes")
}
