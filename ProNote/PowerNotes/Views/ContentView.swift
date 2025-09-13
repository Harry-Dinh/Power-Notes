//
//  ContentView.swift
//  PowerNotes
//
//  Created by Harry Dinh on 2025-07-31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {

            }

            Tab("Search", systemImage: "magnifyingglass", role: .search) {

            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ContentView()
}
