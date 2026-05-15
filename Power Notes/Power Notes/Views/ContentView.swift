//
//  ContentView.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-02-21.
//

import SwiftUI

struct ContentView: View {
    @Environment(UserContentManager.self) private var userContentManager
    @Environment(SidebarViewModel.self) private var sidebarViewModel
    
    var body: some View {
        @Bindable var sidebarViewModel = sidebarViewModel
        
        NavigationSplitView {
            List(selection: $sidebarViewModel.selectedSidebarItem) {
                Section {
                    NavigationLink(value: inboxFolder.uuid) {
                        Label(inboxFolder.name, systemImage: "tray")
                    }
                }
                
                Section("My Folders") {
                    // TODO: User folders here... (future implementation)
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Folders")
            .onAppear {
                if sidebarViewModel.selectedSidebarItem == nil {
                    sidebarViewModel.selectedSidebarItem = inboxFolder.uuid
                }
            }
            // MARK: Sidebar Toolbar
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    newFolderButton
                }
            }
        } content: {
            if let selectedFolder {
                FolderDetailView(folder: selectedFolder)
            } else {
                ContentUnavailableView("No Folder Selected", systemImage: "folder")
            }
        } detail: {
            ContentUnavailableView("No Note Selected", systemImage: "note.text")
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
    
    // MARK: - Helper Functions and Properties
    
    private var selectedFolder: PNFolder? {
        userContentManager.staticFolders.first(where: { $0.uuid == sidebarViewModel.selectedSidebarItem })
    }
    
    private var inboxFolder: PNFolder {
        userContentManager.staticFolders[0]
    }
}

#Preview(traits: .landscapeLeft) {
    ContentView()
}
