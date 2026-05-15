//
//  Power_NotesApp.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-02-21.
//

import SwiftUI
import SwiftData

@main
struct Power_NotesApp: App {
    @State private var userContentManager = UserContentManager.shared
    @State private var sidebarViewModel = SidebarViewModel()
    
    private let persistentModels: [any PersistentModel.Type] = [
        PNFolder.self,
        PNNote.self
    ]
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(userContentManager)
                .environment(sidebarViewModel)
        }
        .modelContainer(for: persistentModels)
    }
}
