//
//  ThumbnailOverviewView.swift
//  ProNote
//
//  Created by Harry Dinh on 2025-01-01.
//

import SwiftUI
import PDFKit

struct ThumbnailOverviewView: View {
    
    @Binding var notebook: PNNotebookWrapper
    
    @State private var overviewVM = ThumbnailOverviewVM.instance
    
    @Environment(\.dismiss) var dismissModal
    
    var body: some View {
        if let notebook = notebook.notebook {
            NavigationStack {
                List {
                    ForEach(notebook.thumbnails, id: \.self) { thumbnail in
                        Image(uiImage: thumbnail)
                            .resizable()
                            .border(.tertiary, width: 1)
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                    }
                }
                .navigationTitle("Document Overview")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Done") {
                            dismissModal.callAsFunction()
                        }
                    }
                }
            }
            .presentationSizing(.page)
        }
    }
}
