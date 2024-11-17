//
//  NoteCreationView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-16.
//

import SwiftUI

struct NoteCreationView: View {
    
    @State private var noteCreationVM = NoteCreationVM.instance
    @Environment(\.dismiss) var dismissModelAction
    
    var body: some View {
        NavigationStack {
            Form {
                
            }
            .navigationTitle("Create New Notebook")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismissModelAction.callAsFunction()
                    }) {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismissModelAction.callAsFunction()
                    }) {
                        Text("Create")
                            .fontWeight(.semibold)
                    }
                }
            }
            .interactiveDismissDisabled()
        }
    }
}

#Preview {
    NoteCreationView()
}
