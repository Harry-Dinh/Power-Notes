//
//  NoteCreationView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-16.
//

import SwiftUI

struct NoteCreationView: View {
    
    @State private var noteCreationVM = NoteCreationVM.instance
    @State private var mainEditVM = MainEditVM.instance
    @State private var primaryVM = PrimaryVM.instance
    @Environment(\.dismiss) var dismissModelAction
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Spacer()
                    Image(systemName: "text.book.closed.fill")
                    Spacer()
                }
                .font(.system(size: 100))
                .listRowBackground(Color.clear)
                
                Section {
                    TextField("Notebook name", text: $noteCreationVM.notebookName)
                }
            }
            .navigationTitle("Create New Notebook")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismissModelAction.callAsFunction()
                    }) {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        let notebook = noteCreationVM.createNotebook()  // Let's hope this is not creating a copy of the same one that was added to the primary vm array...
                        mainEditVM.currentNotebook = notebook
                        dismissModelAction.callAsFunction()
                        
                        if (!primaryVM.openNotebookOnDismiss) {
                            primaryVM.openNotebookOnDismiss = true
                        }
                    }) {
                        Text("Create")
                            .fontWeight(.semibold)
                    }
                    .disabled(noteCreationVM.notebookName.isEmpty)
                }
            }
            .interactiveDismissDisabled()
            .fullScreenCover(isPresented: $noteCreationVM.openNotebook) {
                MainEditView(mainEditVM.currentNotebook)
            }
        }
    }
}

#Preview {
    NoteCreationView()
}
