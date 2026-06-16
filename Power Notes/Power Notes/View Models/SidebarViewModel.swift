//
//  SidebarViewModel.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-15.
//

import Observation
import Foundation

@Observable
class SidebarViewModel {
    var selectedFolder: PNFolder?
    var selectedFolderForDeletion: PNFolder?
    var selectedFolderForRename: PNFolder?
    var newNoteType: PNNoteType?
    
    var showNewFolderAlert = false
    var showNewNoteCreationSheet = false
    var showFolderDeletionAlert = false
    var showFolderRenameAlert = false
    
    var newFolderName = ""
    var renameFolderOldName = ""
}
