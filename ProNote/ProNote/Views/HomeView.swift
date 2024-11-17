//
//  HomeView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-13.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationSplitView {
            HomeSidebarView()
        } detail: {
            HomepageView()
        }
    }
}

#Preview {
    HomeView()
}
