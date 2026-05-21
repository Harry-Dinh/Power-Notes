//
//  NoteEditingView.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-21.
//

import SwiftUI

struct NoteEditingView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                // TODO: Note content here...
            }
            .navigationTitle("Sample note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    dismissButton
                }
                
                ToolbarItem(placement: .navigation) {
                    Button("Document Overview", systemImage: "square.grid.2x2") {}
                }
                
                ToolbarItemGroup(placement: .secondaryAction) {
                    Toggle(
                        "Drawing Tools",
                        systemImage: "pencil.tip.crop.circle",
                        isOn: .constant(false)
                    )
                    
                    Toggle(
                        "Shape Tools",
                        systemImage: "square.on.circle",
                        isOn: .constant(false)
                    )
                }
            }
        }
    }
    
    private var dismissButton: some View {
        Button(
            "Close",
            systemImage: "xmark",
            action: dismiss.callAsFunction
        )
    }
}

#Preview {
    NoteEditingView()
}
