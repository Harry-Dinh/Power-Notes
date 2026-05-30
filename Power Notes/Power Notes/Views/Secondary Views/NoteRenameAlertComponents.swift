//
//  NoteRenameAlertComponents.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-30.
//

import SwiftUI

struct NoteRenameAlertComponents: View {
    @Bindable var folderDetailViewModel: FolderDetailViewModel
    
    init(_ folderDetailViewModel: FolderDetailViewModel) {
        self.folderDetailViewModel = folderDetailViewModel
    }
    
    var body: some View {
        Group {
            TextField("Note name", text: $folderDetailViewModel.renameNoteName)
            
            Button(role: .cancel) {
                folderDetailViewModel.noteRenameDismissAction()
            }
            
            Button("Rename", role: .confirm) {
                folderDetailViewModel.noteRenameDismissAction {
                    folderDetailViewModel.selectedNoteForEdit?.name = folderDetailViewModel.renameNoteName
                }
            }
            .keyboardShortcut(.defaultAction)
            .disabled(folderDetailViewModel.renameNoteName.isEmpty)
        }
    }
}
