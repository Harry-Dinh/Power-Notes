//
//  NoteEditingView.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-21.
//

import SwiftUI

struct NoteEditingView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(NoteEditingViewModel.self) private var noteEditingViewModel
    @Environment(FolderDetailViewModel.self) private var folderDetailViewModel
    
    var body: some View {
        @Bindable var noteEditingViewModel = noteEditingViewModel
        @Bindable var folderDetailViewModel = folderDetailViewModel
        
        NavigationStack {
            VStack {
                // TODO: Note content here...
            }
            .navigationTitle(currentNoteBindable.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbarRole(.editor)
            // MARK: Title Toolbar
            .toolbarTitleMenu {
                RenameButton()
            }
            // MARK: Main Toolbar (iPad full screen)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    dismissButton
                }
                
                ToolbarItemGroup(placement: .secondaryAction) {
                    drawingToolsToggle
                    shapesToolToggle
                }
                
                ToolbarItemGroup(placement: .primaryAction) {
                    undoButton
                    redoButton
                }
                
                ToolbarSpacer(.fixed, placement: .primaryAction)
                
                ToolbarItem(placement: .primaryAction) {
                    documentOverviewButton
                }
            }
            // MARK: Alerts
            .alert(
                "Rename Note",
                isPresented: $folderDetailViewModel.showNoteRenameAlert
            ) {
                NoteRenameAlertComponents(folderDetailViewModel)
            }
        }
    }
    
    // MARK: - Title Toolbar Buttons
    
    // MARK: - Toolbar Buttons
    
    private var dismissButton: some View {
        Button("Close", systemImage: "xmark") {
            noteEditingViewModel.cleanUpBeforeDismiss()
            dismiss()
        }
    }
    
    private var documentOverviewButton: some View {
        Button("Document Overview", systemImage: "square.grid.2x2") {}
    }
    
    private var drawingToolsToggle: some View {
        Toggle(
            "Drawing Tools",
            systemImage: "pencil.tip.crop.circle",
            isOn: .constant(false)
        )
    }
    
    private var shapesToolToggle: some View {
        Toggle(
            "Shape Tools",
            systemImage: "square.on.circle",
            isOn: .constant(false)
        )
    }
    
    private var undoButton: some View {
        Button("Undo", systemImage: "arrow.uturn.backward") {}
    }
    
    private var redoButton: some View {
        Button("Redo", systemImage: "arrow.uturn.forward") {}
    }
    
    // MARK: - Helper Functions and Properties
    
    private var currentNoteBindable: Binding<PNNote> {
        Binding {
            noteEditingViewModel.currentNote ?? .placeholder
        } set: { newValue in
            noteEditingViewModel.currentNote = newValue
        }
    }
}

#Preview(traits: .landscapeLeft) {
    NoteEditingView()
}
