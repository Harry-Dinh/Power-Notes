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
                                // TODO: Add a context menu here for rename, delete, move...
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
                    Button(action: {}) {
                        Image(systemName: "folder.badge.plus")
                    }
                    
                    Menu {
                        Button("New Notebook...") {
                            primaryVM.showNotebookCreationView.toggle()
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
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
