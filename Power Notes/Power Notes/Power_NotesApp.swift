//
//  Power_NotesApp.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-02-21.
//

import SwiftUI
import SwiftData

@main
struct Power_NotesApp: App {
    @State private var sidebarViewModel = SidebarViewModel()
    @State private var noteEditingViewModel = NoteEditingViewModel()
    @State private var folderDetailViewModel = FolderDetailViewModel()
    
    private let persistentModels: [any PersistentModel.Type] = [
        PNFolder.self,
        PNNote.self
    ]
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(sidebarViewModel)
                .environment(noteEditingViewModel)
                .environment(folderDetailViewModel)
        }
        .modelContainer(for: persistentModels)
        .commands {
            CommandGroup(replacing: .newItem) {
                Button(action: {
                    sidebarViewModel.showNewNoteCreationSheet = true
                }) {
                    Label("New Note", systemImage: "square.and.pencil")
                }
                .keyboardShortcut("N")
                .disabled(sidebarViewModel.selectedFolder == nil)
                
                Button(action: {
                    sidebarViewModel.showNewFolderAlert = true
                }) {
                    Label("New Folder", systemImage: "folder.badge.plus")
                }
                .keyboardShortcut("N", modifiers: [.command, .shift])
            }
        }
    }
}
