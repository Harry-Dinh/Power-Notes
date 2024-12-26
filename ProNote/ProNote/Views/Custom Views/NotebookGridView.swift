//
//  NotebookView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import SwiftUI

struct NotebookGridView: View {
    
    var notebook: PNNotebook
    
    init(_ notebook: PNNotebook) {
        self.notebook = notebook
    }
    
    var body: some View {
        // This method might be inefficient :P
        if let document = notebook.document, let thumbnail = PreviewManager.convertPDFToImage(document: document, pageIndex: 0) {
            VStack(spacing: 10) {
                Image(uiImage: thumbnail)
                    .resizable()
                    .border(.tertiary, width: 1)
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.vertical)
                
                Text(notebook.name)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .font(.subheadline)
            }
            .frame(width: PNConstants.NOTE_VIEW_GRID_DIMENSION, height: PNConstants.NOTE_VIEW_GRID_DIMENSION)
            .contextMenu {
                Button(action: {}) {
                    Label("Rename...", systemImage: "pencil")
                }
                
                Button(action: {}) {
                    Label("Move...", systemImage: "folder")
                }
                
                Button(action: {}) {
                    Label("Bookmark Note", systemImage: "bookmark")
                }
                
                Menu("New Page At...") {
                    Button(action: {}) {
                        Label("End", systemImage: "arrow.down.doc")
                    }
                    
                    Button(action: {}) {
                        Label("Beginning", systemImage: "arrow.up.doc")
                    }
                }
                
                Divider()
                
                Button(role: .destructive, action: {}) {
                    Label("Delete...", systemImage: "trash")
                }
            }
        } else {
            VStack(spacing: 10) {
                Image(systemName: "text.book.closed.fill")
                    .font(.system(size: 100))
                Text(notebook.name)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .font(.subheadline)
            }
            .frame(width: PNConstants.NOTE_VIEW_GRID_DIMENSION, height: PNConstants.NOTE_VIEW_GRID_DIMENSION)
        }
    }
}

//#Preview {
//    NotebookGridView(PNNotebook.PLACEHOLDER)
//}
