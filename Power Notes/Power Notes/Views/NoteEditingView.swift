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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    init() {
        UISegmentedControl.appearance().apportionsSegmentWidthsByContent = true
    }
    
    var body: some View {
        @Bindable var folderDetailViewModel = folderDetailViewModel
        
        NavigationStack {
            VStack {
                PDFMarkupView(note: currentNoteBindable, noteEditingViewModel)
                    .ignoresSafeArea()
            }
            .navigationTitle(currentNoteBindable.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .scrollEdgeEffectStyle(.hard, for: .top)
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
                
                if noteEditingViewModel.isToolkitVisible {
                    ToolbarItemGroup(placement: horizontalSizeClass == .regular ? .secondaryAction : .bottomBar) {
                        segmentedToolPicker
                    }
                }
                
                if !isRegularSize {
                    ToolbarSpacer(.flexible, placement: .bottomBar)
                }
                
                ToolbarItemGroup(placement: isRegularSize ? .primaryAction : .bottomBar) {
                    drawingToolsToggle
                    shapesToolToggle
                }
                
                ToolbarSpacer(.fixed, placement: .primaryAction)
                
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
            // MARK: Other modifiers
            .onAppear {
                noteEditingViewModel.selectedTool = noteEditingViewModel.tools[0]
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
    
    @ViewBuilder
    private var drawingToolsToggle: some View {
        @Bindable var noteEditingViewModel = noteEditingViewModel
        
        Toggle(
            "Drawing Tools",
            systemImage: "pencil.tip.crop.circle",
            isOn: $noteEditingViewModel.isToolkitVisible.animation(.bouncy)
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
    
    @ViewBuilder
    private var segmentedToolPicker: some View {
        ForEach(noteEditingViewModel.tools) { tool in
            Button(action: {
                noteEditingViewModel.selectedTool = tool
            }) {
                Label {
                    Text(tool.id)
                } icon: {
                    PNWritingTool.icon(for: tool.toolType)
                }
                .tag(tool.toolType)
                .foregroundStyle(isSelectedTool(tool) ? Color.accentColor : Color.primary)
                .padding(7)
                .background(isSelectedTool(tool) ? Color(.secondarySystemFill) : Color.clear)
                .clipShape(.circle)
            }
            .buttonStyle(.plain)
        }
    }
    
    // MARK: - Helper Functions and Properties
    
    private func isSelectedTool(_ tool: PNWritingTool) -> Bool {
        return noteEditingViewModel.selectedTool?.toolType == tool.toolType
    }
    
    private var currentNoteBindable: Binding<PNNote> {
        Binding {
            noteEditingViewModel.currentNote ?? .placeholder
        } set: { newValue in
            noteEditingViewModel.currentNote = newValue
        }
    }
    
    private var isRegularSize: Bool {
        horizontalSizeClass == .regular
    }
}

#Preview(traits: .landscapeLeft) {
    NoteEditingView()
}
