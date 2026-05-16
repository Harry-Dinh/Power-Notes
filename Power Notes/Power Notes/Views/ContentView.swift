//
//  ContentView.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-02-21.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(UserContentManager.self) private var userContentManager
    @Environment(SidebarViewModel.self) private var sidebarViewModel
    @Environment(\.modelContext) private var modelContext
    
    @Query private var userFolders: [PNFolder]
    
    var body: some View {
        @Bindable var sidebarViewModel = sidebarViewModel
        
        NavigationSplitView {
            ZStack {
                if userFolders.isEmpty {
                    ContentUnavailableView {
                        Text("No Folders")
                    }
                }
                
                List(userFolders, selection: $sidebarViewModel.selectedFolder) { folder in
                    NavigationLink(value: folder) {
                        folderRowView(folder)
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
                let createdFolder = PNFolder(name: sidebarViewModel.newFolderName, iconName: "folder")
                modelContext.insert(createdFolder)
                try? modelContext.save()
                sidebarViewModel.newFolderName = ""
            }
            .keyboardShortcut(.defaultAction)
            .disabled(sidebarViewModel.newFolderName.isEmpty)
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
    
    private func folderRowView(_ folder: PNFolder) -> some View {
        Label(
            folder.name,
            systemImage: folder.uuid == Constants.inboxFolderUUID ? "tray" : "folder"
        )
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
    
    private var inboxFolder: PNFolder {
        userContentManager.staticFolders[0]
    }
}

#Preview(traits: .landscapeLeft) {
    ContentView()
}
