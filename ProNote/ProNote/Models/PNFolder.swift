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
}
