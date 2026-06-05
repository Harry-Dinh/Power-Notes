//
//  NewNoteView.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-21.
//

import SwiftUI
import SwiftData

struct NewNoteView: View {
    @Environment(SidebarViewModel.self) private var sidebarViewModel
    @Environment(NoteEditingViewModel.self) private var noteEditingViewModel
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var folderDetailViewModel: FolderDetailViewModel
    
    @Query private var userFolders: [PNFolder]
    @State private var selectedFolder: PNFolder?
    @State private var selectedHandwrittenTemplate: PNWritingPaperTypes = .blank
    @FocusState private var isTextFieldFocused: Bool?
    
    init(_ folderDetailViewModel: FolderDetailViewModel) {
        self.folderDetailViewModel = folderDetailViewModel
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("New Note", text: $folderDetailViewModel.newNoteName)
                        .focused($isTextFieldFocused, equals: true)
                        .onSubmit {
                            isTextFieldFocused = false
                            createNewNoteAction()
                        }
                }
                
                Section {
                    Picker(
                        "Place new note in:",
                        selection: $selectedFolder
                    ) {
                        if let inboxFolder = userFolders.first(where: { $0.isInboxFolder }) {
                            Section {
                                Text(inboxFolder.name).tag(inboxFolder)
                            }
                        }
                        
                        Section {
                            ForEach(userFolders) { folder in
                                if !folder.isInboxFolder {
                                    Text(folder.name).tag(folder)
                                }
                            }
                        }
                    }
                }
                
                if newNoteType == .handwritten {
                    Section("Template") {
                        templatePicker
                    }
                }
            }
            .navigationTitle(newNoteType == .typed ? "New Typed Note" : "New Handwritten Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .cancel, action: dismissAction) {
                        Label("Cancel", systemImage: "xmark")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(role: .confirm, action: createNewNoteAction) {
                        Label("Create", systemImage: "checkmark")
                    }
                    .disabled(folderDetailViewModel.newNoteName.isEmpty)
                }
            }
        }
        .presentationSizing(.page)
        .onAppear {
            selectedFolder = sidebarViewModel.selectedFolder
            isTextFieldFocused = true
        }
    }
    
    private var templatePicker: some View {
        HStack(alignment: .bottom) {
            Spacer()
            ForEach(PNWritingPaperTypes.allCases, id: \.hashValue) { paperType in
                templatePickerLabel(for: paperType)
                Spacer()
            }
        }
    }
    
    private func templatePickerLabel(for writingPaper: PNWritingPaperTypes) -> some View {
        VStack {
            writingPaperTypeIcon(for: writingPaper)
                .tint(.accentColor)
                .font(.largeTitle)
                .frame(height: 60)
            Text(writingPaper.rawValue)
            
            Group {
                if selectedHandwrittenTemplate == writingPaper {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.white, .blue)
                } else {
                    Image(systemName: "circle")
                }
            }
            .font(.title3)
            .padding(.top, 5)
        }
        .onTapGesture {
            selectedHandwrittenTemplate = writingPaper
        }
    }
    
    // MARK: - Helper Functions and Properties
    
    private func dismissAction() {
        dismiss()
        folderDetailViewModel.newNoteName = ""
        sidebarViewModel.newNoteType = nil
    }
    
    private func createNewNoteAction() {
        guard let selectedFolder,
              let actualSelectedFolder = sidebarViewModel.selectedFolder else {
            return
        }
        
        if selectedFolder != actualSelectedFolder {
            sidebarViewModel.selectedFolder = selectedFolder
        }
        
        let newNote = PNNote(name: folderDetailViewModel.newNoteName, noteType: newNoteType)
        sidebarViewModel.selectedFolder?.notes?.append(newNote)
        
        folderDetailViewModel.newNoteName = ""
        dismiss()
        
        // Create and assign blank page PDF document to the new note
//        if newNote.noteType == .handwritten {
//            // TODO: Change this to a template picker before assigning in the future
//            Task(priority: .userInitiated) {
//                let pdfDocument = await PDFGenerationManager.shared.createWritingPaperPDF()
//                await MainActor.run { newNote.pdfDocument = pdfDocument }
//            }
//        }
//        noteEditingViewModel.open(newNote)
    }
    
    private func writingPaperTypeIcon(for paperType: PNWritingPaperTypes) -> Image {
        switch paperType {
        case .blank:
            return Image(systemName: "circle.slash")
        case .lined:
            return Image(systemName: "line.3.horizontal")
        case .grid:
            return Image(systemName: "grid")
        }
    }
    
    private var newNoteType: PNNoteType {
        sidebarViewModel.newNoteType ?? .typed
    }
}

#Preview(traits: .landscapeLeft) {
    NewNoteView(FolderDetailViewModel())
}
