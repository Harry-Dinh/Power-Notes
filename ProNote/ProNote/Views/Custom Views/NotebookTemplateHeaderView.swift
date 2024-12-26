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
        HStack(spacing: 60) {
            Spacer()
            
            // MARK: - Front Cover Template View
            VStack {
                if let frontCoverTemplate = noteCreationVM.selectedCover {
                    VStack {
                        Image(uiImage: frontCoverTemplate)
                            .resizable()
                            .border(.tertiary, width: 1)
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        Text("Front Cover")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                } else {
                    VStack {
                        Image(systemName: "doc.richtext")
                            .font(.system(size: 130))
                            .foregroundStyle(.secondary)
                        Text("Front Cover")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
            // MARK: - Writing Template View
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
                    VStack {
                        Image(systemName: "doc.plaintext")
                            .font(.system(size: 130))
                            .foregroundStyle(.secondary)
                        Text("Page Template")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    NoteCreationView()
}
