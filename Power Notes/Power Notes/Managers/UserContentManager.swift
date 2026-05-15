//
//  UserContentManager.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-14.
//

import Observation
import Foundation

@Observable
class UserContentManager {
    static let shared = UserContentManager()
    
    var staticFolders: [PNFolder] = [
        PNFolder(
            uuid: Constants.inboxFolderUUID,
            name: "Inbox",
            iconName: "tray"
        )
    ]
}
