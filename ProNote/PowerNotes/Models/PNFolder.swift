//
//  PNFolder.swift
//  ProNote
//
//  Created by Harry Dinh on 2025-09-13.
//

import SwiftUI

struct PNSystemFolder {
    var systemTab: RootViewModel.CoreTab
    var items: [Any]?

    init(for systemTab: RootViewModel.CoreTab, items: [Any]? = nil) {
        self.systemTab = systemTab
        self.items = items
    }
}

struct PNFolder: Identifiable {
    var id: String
    var name: String
    var icon: String?
    var color: Color?
    var items: [Any]?

    init() {
        self.id = UUID().uuidString
        self.name = "Untitled Folder"
        self.icon = nil
        self.color = nil
        self.items = nil
    }
}
