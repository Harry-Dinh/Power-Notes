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
    @State private var mainEditVM = MainEditVM.instance
    
    init() {
        // Run any functions in here that you want to run when the app launches!
        
        // Prepare template thumbnails
        primaryVM.preloadTemplatesURL()
        primaryVM.convertPDFToThumbnailImages()
        
        // Load the user's tool color palettes
        mainEditVM.loadUserColorPalettes()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
