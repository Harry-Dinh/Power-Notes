//
//  FolderView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import SwiftUI

struct FolderView: View {
    
    @State private var folderVM = FolderVM.instance
    @State private var primaryVM = PrimaryVM.instance
    @State private var noteCreationVM = NoteCreationVM.instance
    @State private var mainEditVM = MainEditVM.instance
    
    init(_ folder: PNFolder) {
        folderVM.currentFolder = folder
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { geometry in
                    let screenWidth = geometry.size.width
                    let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 10), count: Int(screenWidth / 160))
                    
                    ScrollView {
                        // TODO: Want to add a section for folders up here just like in Apple Notes!
                        
                        LazyVGrid(columns: gridColumns) {
                            ForEach(folderVM.currentFolder.notebooks) { notebook in
                                NotebookGridView(notebook)
                                    .onTapGesture {
                                        mainEditVM.currentNotebook = notebook
                                        folderVM.openNotebook.toggle()
                                    }
                            }
                            
//                            ForEach(0..<20) { _ in
//                                NotebookGridView(PNNotebook.PLACEHOLDER)
//                            }
                        }
                    }
                }
            }
            .navigationTitle(folderVM.currentFolder.name)
            .toolbarRole(.browser)
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Menu {
                        Section("View Options") {
                            Picker(selection: $folderVM.selectedViewOption) {
                                Label("Grid", systemImage: "square.grid.2x2").tag(0)
                                Label("List", systemImage: "list.bullet").tag(1)
                            } label: {
                                Text("File Browser Viewing Mode")
                            }
                        }
                        
                        Section("Sort By...") {
                            Picker(selection: $folderVM.selectedSortOption) {
                                Text("Name").tag(0)
                                Text("Date Created").tag(1)
                                Text("Date Edited").tag(2)
                            } label: {
                                Text("Sorting Mode")
                            }
                        }

                    } label: {
                        Image(systemName: "square.grid.2x2")
                    }
                    .menuIndicator(.visible)
                    
                    Menu {
                        Button(action: {
                            let quickNote = noteCreationVM.createQuickNote()
                            mainEditVM.currentNotebook = quickNote
                            folderVM.openNotebook.toggle()
                        }) {
                            Label("New Quick Note", systemImage: "note.text")
                        }
                        
                        Button(action: {}) {
                            Label("New Folder...", systemImage: "folder.badge.plus")
                        }
                        
                        Button(action: {
                            primaryVM.showNotebookCreationView.toggle()
                        }) {
                            Label("New Notebook...", systemImage: "text.book.closed")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                    .menuIndicator(.visible)
                }
            }
            .fullScreenCover(isPresented: $folderVM.openNotebook, content: {
                MainEditView()
            })
            .sheet(isPresented: $primaryVM.showNotebookCreationView) {
                folderVM.openNotebook.toggle()
            } content: {
                NoteCreationView()
            }
        }
    }
}

#Preview {
    FolderView(PNFolder.PLACEHOLDER)
}
