//
//  RootSidebarView.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-13.
//

import SwiftUI

struct RootSidebarView: View {
    var body: some View {
        List {
            
        }
        .listStyle(.sidebar)
        .navigationTitle("Folders")
    }
}

#Preview(traits: .landscapeLeft) {
    NavigationStack {
        RootSidebarView()
    }
}
