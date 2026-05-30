//
//  FolderDetailView.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-15.
//

import SwiftUI
import SwiftData

struct FolderDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @Environment(SidebarViewModel.self) private var sidebarViewModel
    @Environment(NoteEditingViewModel.self) private var noteEditingViewModel
    @Environment(FolderDetailViewModel.self) private var folderDetailViewModel
    
    @Binding var folder: PNFolder
    
    init(folder: Binding<PNFolder>) {
        self._folder = folder
    }
    
    var body: some View {
        @Bindable var sidebarViewModel = sidebarViewModel
        @Bindable var folderDetailViewModel = folderDetailViewModel
        
        ZStack {
            Color(
                colorScheme == .light ?
                    .tertiarySystemGroupedBackground : .systemBackground
            )
                .ignoresSafeArea()
            
            if folder.noteCount != 0 || folder.subfoldersCount != 0 {
                List {
                    subfoldersSection
                    notesSection
                }
                .listRowBackground(Color.clear)
            }
        }
        .navigationTitle(folder.name)
        .navigationSubtitle(
            folder.subfoldersCount == 0 ?
            "\(folder.noteCount) notes" : "\(folder.noteCount) notes • \(folder.subfoldersCount) folders"
        )
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                createNoteButton
                moreMenu
            }
        }
        .sheet(isPresented: $sidebarViewModel.showNewNoteCreationSheet) {
            NewNoteView(folderDetailViewModel)
        }
        .alert(
            "Rename Note",
            isPresented: $folderDetailViewModel.showNoteRenameAlert
        ) {
            NoteRenameAlertComponents(folderDetailViewModel)
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
                    Button(action: {
                        noteEditingViewModel.currentNote = note
                        noteEditingViewModel.showEditingView = true
                    }) {
                        Label(note.name, systemImage: "note.text")
                            .contextMenu {
                                renameNoteButton(for: note)
                                deleteNoteButton(with: note)
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    
    private var createNoteButton: some View {
        Button(action: {
            sidebarViewModel.showNewNoteCreationSheet = true
        }) {
            Label("New Note", systemImage: "square.and.pencil")
        }
    }
    
    @ViewBuilder
    private var moreMenu: some View {
        // TODO: In the future, make sure to disable the edit buttons, not the whole menu
        if !folder.isInboxFolder {
            Menu {
                Button("Rename...", systemImage: "pencil") {
                    sidebarViewModel.selectedFolderForRename = folder
                    sidebarViewModel.showFolderRenameAlert = true
                }
            } label: {
                Label("More", systemImage: "ellipsis")
            }
        }
    }
    
    private func deleteNoteButton(with note: PNNote) -> some View {
        Button(role: .destructive, action: {
            modelContext.delete(note)
            try? modelContext.save()
        }) {
            Label("Delete Note", systemImage: "trash")
        }
    }
    
    private func renameNoteButton(for note: PNNote) -> some View {
        Button("Rename...", systemImage: "pencil") {
            folderDetailViewModel.noteRenameInitAction(for: note)
        }
    }
}

#Preview(traits: .landscapeLeft) {
    FolderDetailView(folder: .constant(.placeholder))
}
