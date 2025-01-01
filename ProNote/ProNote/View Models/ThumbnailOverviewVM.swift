//
//  ThumbnailOverviewVM.swift
//  ProNote
//
//  Created by Harry Dinh on 2025-01-01.
//

import SwiftUI

@Observable
class ThumbnailOverviewVM {
    public static let instance = ThumbnailOverviewVM()
    
    public var currentView = 0      // Switch between "All Pages" and "Outline" view
}
