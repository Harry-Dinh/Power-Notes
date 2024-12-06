//
//  HomeSidebarView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-13.
//

import SwiftUI

struct HomeSidebarView: View {
    
    @State private var primaryVM = PrimaryVM.instance
    
    var body: some View {
        List {
            NavigationLink(destination: FolderView(primaryVM.homeFolder)) {
                Label("Home", systemImage: "house")
            }
            
            NavigationLink(destination: EmptyView()) {
                Label("Bookmarks", systemImage: "bookmark")
            }
            
            NavigationLink(destination: EmptyView()) {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            Section {
                EmptyView()
            } header: {
                Text("Pinned Folders")
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("Power Notes")
    }
}

#Preview {
    NavigationStack {
        HomeSidebarView()
    }
}
