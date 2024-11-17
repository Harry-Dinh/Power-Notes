//
//  NoteCreationView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-16.
//

import SwiftUI

struct NoteCreationView: View {
    var body: some View {
        Form {
            
        }
        .navigationTitle("Create New Notebook")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {}) {
                    Text("Cancel")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Text("Create")
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoteCreationView()
    }
}
