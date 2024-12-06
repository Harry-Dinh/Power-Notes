//
//  PNFolder.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-16.
//

import Foundation

/// An object representing a folder, a container of `PNNotebook` objects
struct PNFolder: Identifiable {
    var id: String
    
    /// A collection of `PNNotebook` objects
    var notebooks: [PNNotebook]
    
    /// A collection of subfolders
    var subfolders: [PNFolder]
    
    /// The human-readable identifier for the folder
    var name: String
    
    /// The folder colour in hex
    var colour: Int
    
    /// The name of the SF symbol icon to display on the folder
    var systemIcon: String
    
    init(_ name: String) {
        self.id = UUID().uuidString
        self.notebooks = []
        self.subfolders = []
        self.name = name
        self.colour = 0x0000
        self.systemIcon = "none"
    }
    
    init(_ id: String, _ notebooks: [PNNotebook], _ subfolders: [PNFolder], _ name: String, _ colour: Int, _ systemIcon: String) {
        self.id = id
        self.notebooks = notebooks
        self.subfolders = subfolders
        self.name = name
        self.colour = colour
        self.systemIcon = systemIcon
    }
    
    public static let PLACEHOLDER = PNFolder("Placeholder")
}
