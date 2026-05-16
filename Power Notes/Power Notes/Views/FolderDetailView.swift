//
//  FolderDetailView.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-15.
//

import SwiftUI

struct FolderDetailView: View {
    @Binding var folder: PNFolder
    
    @State private var folderDetailViewModel = FolderDetailViewModel()
    
    init(folder: Binding<PNFolder>) {
        self._folder = folder
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
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                createNoteButton
            }
        }
        .alert(
            "Create New Note",
            isPresented: $folderDetailViewModel.showNewNoteNameAlert
        ) {
            TextField("New Note", text: $folderDetailViewModel.newNoteName)
            
            Button(role: .cancel) { folderDetailViewModel.newNoteName = "" }
            Button("Create", role: .confirm) {
                let newNote = PNNote(name: folderDetailViewModel.newNoteName)
                folder.notes?.append(newNote)
                folderDetailViewModel.newNoteName = ""
            }
        }
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
    
    private var createNoteButton: some View {
        Button(action: {
            folderDetailViewModel.newNoteName = Constants.placeholderNewNoteName
            folderDetailViewModel.showNewNoteNameAlert = true
        }) {
            Label("New Note", systemImage: "square.and.pencil")
        }
    }
}

#Preview(traits: .landscapeLeft) {
    FolderDetailView(folder: .constant(.placeholder))
}
