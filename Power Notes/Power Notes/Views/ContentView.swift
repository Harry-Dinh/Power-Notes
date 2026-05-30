//
//  ContentView.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-02-21.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Environment(SidebarViewModel.self) private var sidebarViewModel
    @Environment(NoteEditingViewModel.self) private var noteEditingViewModel
    @Environment(FolderDetailViewModel.self) private var folderDetailViewModel
    
    @Query private var userFolders: [PNFolder]
    @Query private var userNotes: [PNNote]
    
    var body: some View {
        @Bindable var sidebarViewModel = sidebarViewModel
        @Bindable var noteEditingViewModel = noteEditingViewModel
        
        NavigationSplitView {
            ZStack {
                if userFolders.isEmpty {
                    ContentUnavailableView {
                        Text("No Folders")
                    }
                }
                
                List(selection: $sidebarViewModel.selectedFolder) {
                    Section {
                        if let inboxFolder = userFolders.first(where: { $0.isInboxFolder }) {
                            folderRowView(inboxFolder)
                        }
                    }
                    
                    Section("My Folders") {
                        ForEach(userFolders) { userFolder in
                            if !userFolder.isInboxFolder {
                                folderRowView(userFolder)
                            }
                        }
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Folders")
            // MARK: Sidebar Toolbar
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    newFolderButton
                }
            }
            .onAppear {
                if (userFolders.isEmpty && userNotes.isEmpty) || !userFolders.contains(where: { $0.isInboxFolder }) {
                    let inboxFolder = PNFolder(uuid: Constants.inboxFolderUUID, name: "Inbox")
                    modelContext.insert(inboxFolder)
                    try? modelContext.save()
                }
                
                if sidebarViewModel.selectedFolder == nil && hSizeClass == .regular {
                    sidebarViewModel.selectedFolder = userFolders.first(where: { $0.isInboxFolder })
                }
            }
        } detail: {
            if let selectedFolder = sidebarViewModel.selectedFolder {
                FolderDetailView(folder: selectedFolderBinding(for: selectedFolder))
            } else {
                ContentUnavailableView("No Folder Selected", systemImage: "folder")
            }
        }
        // MARK: Alerts
        .alert(
            "Create New Folder",
            isPresented: $sidebarViewModel.showNewFolderAlert
        ) {
            TextField("New Folder", text: $sidebarViewModel.newFolderName)
            Button(role: .cancel) {
                sidebarViewModel.newFolderName = ""
            }
            Button("Create", role: .confirm) {
                let createdFolder = PNFolder(name: sidebarViewModel.newFolderName)
                modelContext.insert(createdFolder)
                try? modelContext.save()
                sidebarViewModel.newFolderName = ""
            }
            .keyboardShortcut(.defaultAction)
            .disabled(sidebarViewModel.newFolderName.isEmpty)
        }
        .alert(
            "Delete \"\(sidebarViewModel.selectedFolderForDeletion?.name ?? PNFolder.placeholder.name)\"?",
            isPresented: $sidebarViewModel.showFolderDeletionAlert
        ) {
            Button(role: .cancel) {
                sidebarViewModel.selectedFolderForDeletion = nil
            }
            
            Button("Delete", role: .destructive) {
                if let selectedFolderForDeletion = sidebarViewModel.selectedFolderForDeletion {
                    modelContext.delete(selectedFolderForDeletion)
                    try? modelContext.save()
                }
                
                if sidebarViewModel.selectedFolder == sidebarViewModel.selectedFolderForDeletion {
                    sidebarViewModel.selectedFolder = nil
                }
                sidebarViewModel.selectedFolderForDeletion = nil
            }
        }
        .alert(
            "Rename Folder",
            isPresented: $sidebarViewModel.showFolderRenameAlert
        ) {
            if let selectedFolder = Binding($sidebarViewModel.selectedFolderForRename) {
                TextField("Folder name", text: selectedFolder.name)
                Button(role: .cancel) {
                    selectedFolder.wrappedValue.name = sidebarViewModel.renameFolderOldName
                }
                Button(role: .confirm, action: {
                    sidebarViewModel.renameFolderOldName = ""
                }) {
                    Text("Rename")
                }
                .keyboardShortcut(.defaultAction)
                .disabled(selectedFolder.wrappedValue.name.isEmpty)
            }
        }
        // MARK: Note Editing View
        .fullScreenCover(isPresented: $noteEditingViewModel.showEditingView) {
            NoteEditingView()
        }
    }
    
    // MARK: - Subviews
    
    private var newFolderButton: some View {
        Button(action: {
            sidebarViewModel.showNewFolderAlert = true
        }) {
            Label("New Folder", systemImage: "folder.badge.plus")
        }
    }
    
    @ViewBuilder
    private func folderRowView(_ folder: PNFolder) -> some View {
        if folder.isInboxFolder {
            NavigationLink(value: folder) {
                LabeledContent {
                    Text("\(folder.noteCount)")
                } label: {
                    Label(
                        folder.name,
                        systemImage: folder.isInboxFolder ? "tray" : "folder"
                    )
                }
            }
        } else {
            NavigationLink(value: folder) {
                LabeledContent {
                    Text("\(folder.noteCount)")
                } label: {
                    Label(
                        folder.name,
                        systemImage: folder.isInboxFolder ? "tray" : "folder"
                    )
                }
            }
            .contextMenu {
                renameFolderButton(folder)
                deleteFolderButton(folder)
            }
        }
    }
    
    private func deleteFolderButton(_ folder: PNFolder) -> some View {
        Button(role: .destructive, action: {
            sidebarViewModel.selectedFolderForDeletion = folder
            sidebarViewModel.showFolderDeletionAlert = true
        }) {
            Label("Delete...", systemImage: "trash")
        }
    }
    
    private func renameFolderButton(_ folder: PNFolder) -> some View {
        Button(action: {
            sidebarViewModel.selectedFolderForRename = folder
            sidebarViewModel.renameFolderOldName = folder.name
            sidebarViewModel.showFolderRenameAlert = true
        }) {
            Label("Rename...", systemImage: "pencil")
        }
    }
    
    // MARK: - Helper Functions and Properties
    
    private func selectedFolderBinding(for folder: PNFolder) -> Binding<PNFolder> {
        let bindedFolder = Binding {
            return folder
        } set: { newValue in
            sidebarViewModel.selectedFolder = newValue
        }
        return bindedFolder
    }
}

#Preview(traits: .landscapeLeft) {
    ContentView()
}
