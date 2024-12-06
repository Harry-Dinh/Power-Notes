//
//  PNNotebook.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-16.
//

import Foundation

struct PNNotebook: Identifiable {
    var id: String
    var name: String
    var dateCreated: Date
    var lastEdited: Date
    var allPages: [PNPage]
    var isBookmarked: Bool
    
    init() {
        self.id = UUID().uuidString
        self.name = "Untitled Notebook"
        self.dateCreated = Date()
        self.lastEdited = Date()
        self.allPages = [PNPage()]      // All notebook when created should a minimum of 1 page
        self.isBookmarked = false
    }
    
    init(_ name: String) {
        self.id = UUID().uuidString
        self.name = name
        self.dateCreated = Date()
        self.lastEdited = Date()
        self.allPages = [PNPage()]
        self.isBookmarked = false
    }
    
    init(_ id: String, _ name: String, _ dateCreated: Date, _ lastEdited: Date, _ allPages: [PNPage], _ isBookmarked: Bool) {
        self.id = id
        self.name = name
        self.dateCreated = dateCreated
        self.lastEdited = lastEdited
        self.allPages = allPages
        self.isBookmarked = isBookmarked
    }
    
    public static let PLACEHOLDER = PNNotebook("NX-93581", "Test Notebook", Date(), Date(), [], false)
}
