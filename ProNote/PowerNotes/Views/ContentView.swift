//
//  ContentView.swift
//  PowerNotes
//
//  Created by Harry Dinh on 2025-07-31.
//

import SwiftUI

struct ContentView: View {
    @State private var rootViewModel = RootViewModel()

    var body: some View {
        TabView {
            ForEach(RootViewModel.CoreTab.allCases, id: \.rawValue) { tab in
                Tab(
                    tab.rawValue,
                    systemImage: RootViewModel.getIcon(for: tab),
                    role: tab == .search ? .search : .none,
                ) {
                    SystemFolderView(folder: PNSystemFolder(for: tab))
                }
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ContentView()
}
