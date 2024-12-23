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
                    NotebookTemplateHeaderView()
                }
                .listRowBackground(Color.clear)
                
                Section {
                    TextField("Notebook name", text: $noteCreationVM.notebookName)
                        .font(.title2)
                        .padding(.vertical)
                        .multilineTextAlignment(.center)
                }
                
                // MARK: - Notebook Customizations Section
                Section("Notebook Customizations") {
                    Picker("Paper Size", selection: $noteCreationVM.paperSizePickerOption) {
                        Section("Preset") {
                            Text("US Letter").tag(0)
                            Text("A4").tag(1)
                        }
                        
                        Section {
                            Label("Custom...", systemImage: "slider.horizontal.3")
                            Label("Import...", systemImage: "square.and.arrow.down")
                        }
                        
                        Section {
                            Label("Manage Templates...", systemImage: "doc.richtext")
                        }
                    }
                    
                    Toggle(isOn: $noteCreationVM.addCoverToggle) {
                        Text("Add Front Cover")
                    }
                }
                
                // MARK: - Front Cover Selector
                if noteCreationVM.addCoverToggle {
                    Section {
                        ScrollView(.horizontal) {
                            // Add a TemplateSelectorView for front covers here...
                        }
                    } header: {
                        Text("Front Cover")
                    } footer: {
                        Text("Credit page websites here...")
                            .italic()
                    }
                }
                
                // MARK: - Page Template Selector
                Section {
                    TemplateSelectorView(templatesList: primaryVM.templatesThumbnails)
                } header: {
                    Text("Page Templates")
                } footer: {
                    Text("Page templates provided by mathpolate.com")
                }
            }
            .navigationTitle("Create New Notebook")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
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
                        print("Create notebook button pressed")
                        let notebook = noteCreationVM.createNotebook()  // Let's hope this is not creating a copy of the same one that was added to the primary vm array...
                        mainEditVM.currentNotebook = notebook
                        dismissModelAction.callAsFunction()
                    }) {
                        Text("Create")
                            .fontWeight(.semibold)
                    }
                    .disabled(noteCreationVM.notebookName.isEmpty)
                }
            }
        }
    }
}

#Preview {
    NoteCreationView()
}
