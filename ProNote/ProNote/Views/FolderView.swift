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
                    let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 10), count: Int(screenWidth / 120))
                    
                    ScrollView {
                        // TODO: Want to add a section for folders up here just like in Apple Notes!
                        
                        LazyVGrid(columns: gridColumns) {
                            ForEach(folderVM.currentFolder.notebooks) { notebook in
                                NotebookGridView(notebook)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle(folderVM.currentFolder.name)
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
                print("Note creation view dismissed")
                if primaryVM.openNotebookOnDismiss {
                    print("Opening notebook now!")
                    noteCreationVM.openNotebook.toggle()
                    primaryVM.openNotebookOnDismiss = false
                }
            } content: {
                NoteCreationView()
            }
            .fullScreenCover(isPresented: $noteCreationVM.openNotebook) {
                MainEditView(mainEditVM.currentNotebook)
            }
        }
    }
}

#Preview {
    FolderView(PNFolder.PLACEHOLDER)
}
