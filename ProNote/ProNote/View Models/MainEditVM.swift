//
//  MainEditVM.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import Foundation
import SwiftUI

@Observable
class MainEditVM {
    public static let instance = MainEditVM ()
    
    public var currentNotebook = PNNotebook.PLACEHOLDER    // This will be reassigned after the singleton is called
}
