//
//  FolderVM.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-17.
//

import Foundation
import SwiftUI

@Observable
class FolderVM {
    public static let instance = FolderVM()
    
    public var currentFolder = PNFolder.PLACEHOLDER
    
    public var openNotebook = false
    public var selectedViewOption = 0
    public var selectedSortOption = 2
}
