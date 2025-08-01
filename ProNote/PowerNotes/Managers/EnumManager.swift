//
//  EnumManager.swift
//  ProNote
//
//  Created by Harry Dinh on 2025-07-31.
//

import SwiftUI

class EnumManager {
    public static func homeViewModeIndex(for viewMode: HomeViewMode) -> Int {
        switch viewMode {
            case .list:
                return 0
            case .grid:
                return 1
        }
    }

    public static func homeViewModeIcon(for viewMode: HomeViewMode) -> Image {
        switch viewMode {
            case .list:
                Image(systemName: "list.bullet")
            case .grid:
                Image(systemName: "rectangle.grid.2x2")
        }
    }
}
