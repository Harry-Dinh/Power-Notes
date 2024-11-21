//
//  HomeView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-13.
//

import SwiftUI

struct HomeView: View {
    
    @State private var primaryVM = PrimaryVM.instance
    @State private var folderVM = FolderVM.instance
    @State private var mainEditVM = MainEditVM.instance
    
    var body: some View {
        NavigationSplitView {
            HomeSidebarView()
        } detail: {
            FolderView(primaryVM.homeFolder)
        }
        .fullScreenCover(isPresented: $folderVM.openNotebook) {
            MainEditView(mainEditVM.currentNotebook)
        }
    }
}

#Preview {
    HomeView()
}
