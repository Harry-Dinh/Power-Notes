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
}
