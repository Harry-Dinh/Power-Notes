//
//  HomepageView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-16.
//

import SwiftUI

struct HomepageView: View {
    
    @State private var primaryVM = PrimaryVM.instance
    @State private var noteCreationVM = NoteCreationVM.instance
    @State private var mainEditVM = MainEditVM.instance
    
    var body: some View {
        NavigationStack {
            List {
                
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Menu {
                        Button(action: {}) {
                            Label("New Quick Note", systemImage: "doc")
                        }
                        
                        Button(action: {
                            primaryVM.showNotebookCreationView.toggle()
                        }) {
                            Label("New Notebook...", systemImage: "text.book.closed")
                        }
                        
                        Divider()
                        
                        Button(action: {}) {
                            Label("New Folder...", systemImage: "folder")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                    Menu {
                        EditButton()
                        Divider()
                        Button(action: {}) {
                            Label("Settings", systemImage: "gear")
                        }
                        
                        Button(action: {}) {
                            Label("Feedback...", systemImage: "ellipsis.bubble")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .symbolVariant(.circle)
                    }
                }
            }
            .sheet(isPresented: $primaryVM.showNotebookCreationView) {
                if primaryVM.openNotebookOnDismiss {
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
    HomepageView()
}
