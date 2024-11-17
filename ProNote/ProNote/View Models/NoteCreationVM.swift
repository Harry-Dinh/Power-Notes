//
//  NoteCreationVM.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-16.
//

import Foundation
import SwiftUI

@Observable
class NoteCreationVM {
    public static let instance = NoteCreationVM()
    
    public var openNotebook = false
    
    public var notebookName = "Untitled Notebook"
    
    public func createNotebook() -> PNNotebook {
        if notebookName.isEmpty {
            print("Notebook name is empty, unable to create notebook object!")
            return PNNotebook.PLACEHOLDER
        }
        
        // Get the singleton of the Primary VM
        let primaryVM = PrimaryVM.instance
        
        // Create a new notebook then add it to the primary VM array
        let newNotebook = PNNotebook(notebookName)
        primaryVM.allNotes.append(newNotebook)
        return newNotebook
    }
}
