//
//  FolderDetailView.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-15.
//

import SwiftUI

struct FolderDetailView: View {
    @State var folder: PNFolder
    
    init(folder: PNFolder) {
        self.folder = folder
    }
    
    var body: some View {
        ZStack {
            List {
                subfoldersSection
                notesSection
            }
        }
        .navigationTitle(folder.name)
        .navigationSubtitle(
            folder.subfoldersCount == 0 ?
            "\(folder.noteCount) notes" : "\(folder.noteCount) notes • \(folder.subfoldersCount) folders"
        )
    }
    
    @ViewBuilder
    private var subfoldersSection: some View {
        if let subfolders = folder.subfolders, !subfolders.isEmpty {
            Section("Folders") {
                ForEach(subfolders) { subfolder in
                    Label(subfolder.name, systemImage: "folder")
                }
            }
        }
    }
    
    @ViewBuilder
    private var notesSection: some View {
        if let notes = folder.notes, !notes.isEmpty {
            Section("Notes") {
                ForEach(notes) { note in
                    Label(note.name, systemImage: "note.text")
                }
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    FolderDetailView(folder: .placeholder)
}
