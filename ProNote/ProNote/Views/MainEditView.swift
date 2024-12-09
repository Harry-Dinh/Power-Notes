//
//  MainEditView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import SwiftUI

struct MainEditView: View {
    
    @State private var mainEditVM = MainEditVM.instance
    @Environment(\.dismiss) var dismiss
    
    init(_ notebook: PNNotebook) {
        self.mainEditVM.currentNotebook = notebook
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Note: Don't add a scroll view or a VStack here, otherwise it will severely mess up the scrolling and zooming!
                if let pdfURL = Bundle.main.url(forResource: "testPDF2", withExtension: "pdf") {
                    PDFViewWrapper(pdfURL: pdfURL, showMarkupToolbar: $mainEditVM.showMarkupToolbar)
                } else {
                    Text("Failed to load PDF")
                        .foregroundStyle(.red)
                }
                
                if mainEditVM.showMarkupToolbar {
                    GeometryReader { geometry in
                        CustomMarkupToolbar()
                            .position(x: geometry.size.width / 2, y: geometry.safeAreaInsets.top + 100)
                    }
                    .ignoresSafeArea(edges: .top)
                }
            }
            .navigationTitle(mainEditVM.currentNotebook.name)
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
                            Text("Placeholder")
                        } label: {
                            Image(systemName: "doc.badge.plus")
                        } primaryAction: {
                            print("Add page!")
                        }
                        .menuIndicator(.visible)
                    }
                }
                
                ToolbarItemGroup(placement: .primaryAction) {
                    ControlGroup {
                        Button(action: {}) {
                            Image(systemName: "arrow.uturn.backward.circle")
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "arrow.uturn.forward.circle")
                        }
                    }
                    
                    Toggle(isOn: $mainEditVM.showMarkupToolbar) {
                        Image(systemName: "pencil.tip.crop.circle")
                    }
                    .clipShape(Circle())
                    
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
                    Image(systemName: "magnifyingglass")
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

#Preview {
    MainEditView(PNNotebook.PLACEHOLDER)
}
