//
//  PNUser.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-16.
//

import Foundation

struct PNUser {
    var firebaseID: String
    var displayName: String
    var email: String
    var folders: [PNFolder]
    
    init() {
        self.firebaseID = UUID().uuidString
        self.displayName = "Generic User"
        self.email = "genericuser@genericemail.com"
        self.folders = []
    }
    
    init(_ firebaseID: String, _ displayName: String, _ email: String, _ folders: [PNFolder]) {
        self.firebaseID = firebaseID
        self.displayName = displayName
        self.email = email
        self.folders = folders
    }
    
    public static let PLACEHOLDER = PNUser("00000000000", "Generic User", "genericuser@genericemail.com", [])
}
