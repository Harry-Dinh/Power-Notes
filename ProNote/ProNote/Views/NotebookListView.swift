//
//  NotebookListView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import SwiftUI

struct NotebookListView: View {
    
    var notebook: PNNotebook
    
    init(_ notebook: PNNotebook) {
        self.notebook = notebook
    }
    
    var body: some View {
        HStack {
            Image(systemName: "text.book.closed.fill")
                .font(.system(size: 50))
            Text(notebook.name)
        }
    }
}

#Preview {
    NotebookListView(PNNotebook.PLACEHOLDER)
}
