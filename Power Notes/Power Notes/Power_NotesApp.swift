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
                createNewNoteMenu
                newFolderButton
            }
            
            SidebarCommands()
        }
    }
    
    // MARK: - File Menu
    
    private var createNewNoteMenu: some View {
        Menu {
            Button("Typed Note") {
                sidebarViewModel.newNoteType = .typed
                sidebarViewModel.showNewNoteCreationSheet = true
            }
            .keyboardShortcut("N")  // Cmd + N
            
            Button("Handwritten Note") {
                sidebarViewModel.newNoteType = .handwritten
                sidebarViewModel.showNewNoteCreationSheet = true
            }
            .keyboardShortcut("N", modifiers: [.command, .option])  // Opt + Cmd + N
        } label: {
            Label("New Note", systemImage: "square.and.pencil")
        }
        .disabled(sidebarViewModel.selectedFolder == nil)
    }
    
    private var newFolderButton: some View {
        Button(action: {
            sidebarViewModel.showNewFolderAlert = true
        }) {
            Label("New Folder", systemImage: "folder.badge.plus")
        }
        .keyboardShortcut("N", modifiers: [.command, .shift])   // Shift + Cmd + N
    }
}
