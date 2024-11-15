//
//  HomeSidebarView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-13.
//

import SwiftUI

struct HomeSidebarView: View {
    var body: some View {
        List {
            NavigationLink(destination: EmptyView()) {
                Label("Home", systemImage: "house")
            }
            
            NavigationLink(destination: EmptyView()) {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            Section {
                EmptyView()
            } header: {
                Text("My Folders")
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("Power Notes")
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(action: {}) { Image(systemName: "folder.badge.plus") }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeSidebarView()
    }
}
