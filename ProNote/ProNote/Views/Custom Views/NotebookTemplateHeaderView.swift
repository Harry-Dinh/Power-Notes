//
//  NotebookTemplateHeaderView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-23.
//

import SwiftUI

struct NotebookTemplateHeaderView: View {
    
    @State private var noteCreationVM = NoteCreationVM.instance
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                if let selectedTemplate = noteCreationVM.selectedTemplate {
                    VStack {
                        Image(uiImage: selectedTemplate)
                            .resizable()
                            .border(.tertiary, width: 1)
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        Text("Page Template")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                } else {
                    Image(systemName: "doc.plaintext")
                        .font(.system(size: 130))
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    NoteCreationView()
}
