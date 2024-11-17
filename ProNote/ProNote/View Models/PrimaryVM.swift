//
//  PrimaryVM.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import Foundation
import SwiftUI

@Observable
class PrimaryVM {
    public static let instance = PrimaryVM()
    
    public var showNotebookCreationView = false
    public var openNotebookOnDismiss = false
    
    // TODO: Note to self: In the future, replace these with a centralized user object whose data is fetched from Firebase
    public var allNotes: [PNNotebook] = []
    public var allFolders: [PNFolder] = []
}
