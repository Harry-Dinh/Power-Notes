//
//  ThumbnailOverviewView.swift
//  ProNote
//
//  Created by Harry Dinh on 2025-01-01.
//

import SwiftUI

struct ThumbnailOverviewView: View {
    
    @Binding var notebook: PNNotebookWrapper
    
    @State private var overviewVM = ThumbnailOverviewVM.instance
    
    @Environment(\.dismiss) var dismissModal
    
    var body: some View {
        if let notebook = notebook.notebook {
            NavigationStack {
//                GeometryReader { geometry in
//                    let screenWidth = geometry.size.width
//                    let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 10), count: Int(screenWidth / 160))
//                    
//                    ScrollView {
//                        LazyVGrid(columns: gridColumns) {
//                            ForEach(0..<notebook.thumbnails.count) { index in
//                                ThumbnailPreviewView(thumbnail: notebook.thumbnails[index], indexNumber: index)
//                            }
//                        }
//                    }
//                }
                
                List {
                    ForEach(0..<notebook.thumbnails.count) { index in
                        Label {
                            HStack {
                                Text("Page \(index + 1)")
                                
                                Spacer()
                                
                                Menu {
                                    Button(action: {}) {
                                        Label("Add to Outline...", systemImage: "list.bullet.indent")
                                    }
                                    
                                    Button(action: {}) {
                                        Label("Bookmark Page", systemImage: "bookmark")
                                    }
                                    
                                    Menu {
                                        Button(action: {}) {
                                            Label("Beginning", systemImage: "arrow.up.doc")
                                        }
                                        
                                        Button(action: {}) {
                                            Label("End", systemImage: "arrow.down.doc")
                                        }
                                    } label: {
                                        Text("New Page At...")
                                    }
                                    
                                    Divider()
                                    
                                    Button(role: .destructive) {
                                        
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .symbolVariant(.circle)
                                }
                            }
                        } icon: {
                            Image(uiImage: notebook.thumbnails[index])
                                .resizable()
                                .border(.tertiary, width: 1)
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                        }
                        .onTapGesture {
                            // Jump to page action here...
                            print("Jump to page action triggered")
                        }
                    }
                }
                .navigationTitle("Pages Overview")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismissModal.callAsFunction()
                        }) {
                            Text("Done")
                                .fontWeight(.semibold)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                }
            }
            .presentationSizing(.page)
        }
    }
}
