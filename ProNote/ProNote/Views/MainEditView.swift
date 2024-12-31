//
//  MainEditView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import SwiftUI
import Foundation

struct MainEditView: View {
    
    @State private var mainEditVM = MainEditVM.instance
    @State private var toolbarVM = CustomMarkupToolbarVM.instance
    @Environment(\.dismiss) var dismiss
    @Environment(\.undoManager) var undoManager
    
    // Creation initializer (call after opening existing notes or creating quick notes)
    init() {}
    
    // Default initializer (call when creating a new note)
    init(_ notebook: PNNotebook) {
        self.mainEditVM.currentNotebook = notebook
        
        // Unwrap the document as the view is initializing
        guard let document = notebook.document else {
            fatalError("Cannot unwrap document")
        }
        self.mainEditVM.currentDocumentWrapper = PDFDocumentWrapper(document)
    }
    
    var body: some View {
        if let notebook = mainEditVM.currentNotebook {
            NavigationStack {
                ZStack {
                    DocumentView(documentWrapper: $mainEditVM.currentDocumentWrapper, selectedTool: $toolbarVM.selectedToolData, $toolbarVM.showRuler)
                        .offset(y: mainEditVM.documentViewOffsetAmount)
                    
                    if mainEditVM.showMarkupToolbar {
                        GeometryReader { geometry in
                            CustomMarkupToolbar()
                                .position(x: geometry.size.width / 2, y: geometry.safeAreaInsets.top + 95)
                        }
                        .ignoresSafeArea(edges: .top)
                    }
                }
                .navigationTitle(notebook.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarRole(.editor)
                .toolbar {
                    ToolbarItemGroup(placement: .navigation) {
                        Button(action: {
                            dismiss.callAsFunction()
                            // TODO: Add a function to save progress here
                        }) {
                            Image(systemName: "chevron.left")
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "square.grid.2x2")
                        }
                    }
                    
                    ToolbarItemGroup(placement: .secondaryAction) {
                        ControlGroup {
                            Button(action: {}) {
                                Image(systemName: "photo.on.rectangle")
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "character.textbox")
                            }
                            
                            Menu {
                                NewPageOverlayView()
                            } label: {
                                Image(systemName: "doc.badge.plus")
                            } primaryAction: {
                                mainEditVM.quicklyInsertPageAtEnd()
                            }
                        }
                    }
                    
                    ToolbarItemGroup(placement: .primaryAction) {
                        
                        // MARK: - Undo/Redo Actions
                        ControlGroup {
                            Button(action: {
                                undoManager?.undo()
                            }) {
                                Image(systemName: "arrow.uturn.backward.circle")
                            }
                            .disabled(!(undoManager?.canUndo ?? false))
                            
                            Button(action: {
                                undoManager?.redo()
                            }) {
                                Image(systemName: "arrow.uturn.forward.circle")
                            }
                            .disabled(!(undoManager?.canRedo ?? false))
                        }
                        
                        // MARK: - Toggle Writing Mode
                        Toggle(isOn: $mainEditVM.showMarkupToolbar) {
                            Image(systemName: "pencil.tip.crop.circle")
                        }
                        .clipShape(Circle())
                        .onChange(of: mainEditVM.showMarkupToolbar) {
                            // Ensures the document view moves down when the tool picker is enabled and moves back up when hidden
                            if mainEditVM.showMarkupToolbar {
                                withAnimation(.easeIn) {
                                    mainEditVM.documentViewOffsetAmount = 50
                                }
                            } else {
                                withAnimation(.easeOut) {
                                    mainEditVM.documentViewOffsetAmount = 0
                                }
                            }
                        }
                        
                        // MARK: - Other Actions
                        
                        Button(action: {}) {
                            Image(systemName: "bookmark")
                        }
                        
                        // TODO: This has to be a menu!
                        Button(action: {}) {
                            Image(systemName: "ellipsis")
                                .symbolVariant(.circle)
                        }
                    }
                }
                .navigationBarBackButtonHidden()
                .toolbarTitleMenu {
                    Button(action: {}) {
                        Label("Rename", systemImage: "pencil")
                    }
                    
                    Button(action: {}) {
                        Label("Move", systemImage: "folder")
                    }
                    
                    Button(action: {}) {
                        Label("Bookmark Notebook", systemImage: "bookmark")
                    }
                    
                    Button(action: {}) {
                        Label("Search Document", systemImage: "magnifyingglass")
                    }
                    
                    Button(action: {}) {
                        Label("Duplicate", systemImage: "plus.square.on.square")
                    }
                    
                    Divider()
                    
                    Button(action: {}) {
                        Label("Export as PDF", systemImage: "square.and.arrow.up.on.square")
                    }
                    
                    Button(action: {}) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    
                    Divider()
                    
                    Button(action: {}) {
                        Label("Print", systemImage: "printer")
                    }
                }
            }
        }
    }
}

#Preview {
    MainEditView(PNNotebook.PLACEHOLDER)
}
