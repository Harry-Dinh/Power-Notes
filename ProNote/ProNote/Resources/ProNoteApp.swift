//
//  ProNoteApp.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-13.
//

import SwiftUI

@main
struct ProNoteApp: App {
    
    @State private var primaryVM = PrimaryVM.instance
    
    init() {
        // Run any functions in here that you want to run when the app launches!
        
        // Prepare template thumbnails
        primaryVM.preloadTemplatesURL()
        primaryVM.convertPDFToThumbnailImages()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
