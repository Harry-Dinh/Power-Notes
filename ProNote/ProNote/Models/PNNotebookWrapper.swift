//
//  PNNotebookWrapper.swift
//  ProNote
//
//  Created by Harry Dinh on 2025-01-01.
//

import SwiftUI

@Observable
class PNNotebookWrapper {
    var notebook: PNNotebook?
    
    init(_ notebook: PNNotebook?) {
        self.notebook = notebook
    }
}
