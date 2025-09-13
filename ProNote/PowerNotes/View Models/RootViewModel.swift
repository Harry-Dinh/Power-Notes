//
//  RootViewModel.swift
//  ProNote
//
//  Created by Harry Dinh on 2025-09-13.
//

import SwiftUI
import Observation

@Observable
class RootViewModel {
    enum CoreTab: String, CaseIterable {
        case home = "tab_label_home"
        case bookmarks = "tab_label_bookmarks"
        case search = "tab_label_search"
    }

    static func getIcon(for tab: CoreTab) -> String {
        switch tab {
            case .home:
                return "house"
            case .bookmarks:
                return "bookmark"
            case .search:
                return "magnifyingglass"
        }
    }
}
