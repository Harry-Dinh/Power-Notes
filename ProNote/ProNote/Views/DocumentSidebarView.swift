//
//  DocumentSidebarView.swift
//  ProNote
//
//  Created by Harry Dinh on 2025-02-28.
//

import SwiftUI

struct DocumentSidebarView: View {
    
    @Binding var notebookWrapper: PNNotebookWrapper
    @State private var selectedView = 0
    
    var body: some View {
        if let notebook = notebookWrapper.notebook {
            VStack {
                if notebook.thumbnails.isEmpty {
                    Text("No Pages")
                } else {
                    List {
                        ForEach(notebook.thumbnails, id: \.self) { thumbnail in
                            HStack(alignment: .center) {
                                Spacer()
                                Image(uiImage: thumbnail)
                                    .resizable()
                                    .scaledToFill()
                                    .border(Color.gray, width: 1)
                                    .frame(width: 200, height: 200)
                                    .padding(.top)
                                Spacer()
                            }
                            .padding(.top)
                            .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Thumbnails")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    DocumentSidebarView(notebookWrapper: .constant(PNNotebookWrapper(PNNotebook.PLACEHOLDER)))
}
