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
    
    // This initializer assumes that the notebook was already initialized
    init() {
        // Unwrap the notebook and its document as the view is initializing
        guard let notebook = mainEditVM.currentNotebook.notebook,
              let document = notebook.document else {
            fatalError("Cannot unwrap notebook and/or document")
        }
        
        // Fetch the unwrapped document from the notebook and create a wrapper to work with SwiftUI
        self.mainEditVM.currentDocumentWrapper = PDFDocumentWrapper(document)
        
        // Preload the thumbnails for the overview screen
        self.mainEditVM.preloadNotebookThumbnails()
    }
    
    // Default initializer (call when creating a new note)
    init(_ notebook: PNNotebook) {
        // Assign the notebook and its wrapper object
        self.mainEditVM.currentNotebook = PNNotebookWrapper(notebook)
        
        // Unwrap the document as the view is initializing
        guard let document = notebook.document else {
            fatalError("Cannot unwrap document")
        }
        
        // Fetch the unwrapped document from the notebook and create a wrapper to work with SwiftUI
        self.mainEditVM.currentDocumentWrapper = PDFDocumentWrapper(document)
        
        // Preload the thumbnails for the overview screen
        self.mainEditVM.preloadNotebookThumbnails()
    }
    
    var body: some View {
        if let notebook = mainEditVM.currentNotebook.notebook {
            // The column visibility value passed in will present the sidebar from showing by default
            NavigationSplitView(columnVisibility: $mainEditVM.sidebarVisibility) {
                DocumentSidebarView(notebookWrapper: $mainEditVM.currentNotebook)
            } detail: {
                ZStack {
                    // Main document (edit view)
                    DocumentView(documentWrapper: $mainEditVM.currentDocumentWrapper,
                                 selectedTool: $toolbarVM.selectedToolData,
                                 $toolbarVM.showRuler)
                    .offset(y: mainEditVM.documentViewOffsetAmount)
                    
                    // Markup toolbar
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
                            Image(systemName: "chevron.down")
                        }
                        
    //                        Button(action: {
    //                            mainEditVM.openPageOverview.toggle()
    //                        }) {
    //                            Image(systemName: "sidebar.left")
    //                        }
                    }
                    
                    // MARK: - Center Buttons
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
                        
                        Menu {
                            Toggle(isOn: .constant(false)) {
                                Label("Dynamic Pen Stroke", systemImage: "scribble.variable")
                            }
                        } label: {
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
            .navigationSplitViewStyle(.prominentDetail)
        }
    }
}

#Preview {
    MainEditView(PNNotebook.PLACEHOLDER)
}
