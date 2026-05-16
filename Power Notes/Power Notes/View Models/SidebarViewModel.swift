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
    var showNewFolderAlert = false
    var newFolderName = ""
}
