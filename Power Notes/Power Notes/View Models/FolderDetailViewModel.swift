//
//  FolderDetailViewModel.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-16.
//

import Foundation

@Observable
class FolderDetailViewModel {
    var showNoteRenameAlert = false
    
    var newNoteName = ""
    var renameNoteName = ""
    
    var selectedNoteForEdit: PNNote?
    
    func noteRenameInitAction(for note: PNNote) {
        showNoteRenameAlert = true
        renameNoteName = note.name
        selectedNoteForEdit = note
    }
    
    func noteRenameDismissAction(with actionTakenBeforeDismiss: (() -> Void)? = nil) {
        actionTakenBeforeDismiss?()
        renameNoteName = ""
        selectedNoteForEdit = nil
    }
}
