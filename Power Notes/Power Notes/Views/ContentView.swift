//
//  ContentView.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-02-21.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(SidebarViewModel.self) private var sidebarViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.horizontalSizeClass) private var hSizeClass
    
    @Query private var userFolders: [PNFolder]
    @Query private var userNotes: [PNNote]
    
    var body: some View {
        @Bindable var sidebarViewModel = sidebarViewModel
        
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
