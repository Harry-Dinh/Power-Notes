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
}
