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
    var selectedSidebarItem: UUID?
    var showNewFolderAlert = false
    var newFolderName = ""
}
