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
        }
    }
}

#Preview {
    SystemFolderView(folder: PNSystemFolder(for: .home))
}
