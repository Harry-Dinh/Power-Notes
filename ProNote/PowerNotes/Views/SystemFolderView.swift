//
//  SystemFolderView.swift
//  ProNote
//
//  Created by Harry Dinh on 2025-09-13.
//

import SwiftUI

struct SystemFolderView: View {
    @State private var folder: PNSystemFolder

    init(folder: PNSystemFolder) {
        self.folder = folder
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Folder content here...
            }
            .navigationTitle(folder.systemTab.rawValue)
            .toolbarRole(.browser)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    newItemButton
                }
            }
        }
    }

    private var newItemButton: some View {
        Button(action: {}) {
            Image(systemName: "plus")
        }
    }
}

#Preview {
    SystemFolderView(folder: PNSystemFolder(for: .home))
}
