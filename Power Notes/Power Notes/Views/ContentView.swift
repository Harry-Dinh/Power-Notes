//
//  ContentView.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-02-21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            RootSidebarView()
        } content: {
            
        } detail: {
            
        }
    }
}

#Preview(traits: .landscapeLeft) {
    ContentView()
}
