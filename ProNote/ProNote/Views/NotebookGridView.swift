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
        VStack(spacing: 10) {
            Image(systemName: "text.book.closed.fill")
                .font(.system(size: 100))
            Text(notebook.name)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .font(.subheadline)
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    NotebookGridView(PNNotebook.PLACEHOLDER)
}
