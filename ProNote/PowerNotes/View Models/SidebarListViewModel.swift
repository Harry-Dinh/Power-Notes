//
//  SidebarListViewModel.swift
//  PowerNotes
//
//  Created by Harry Dinh on 2025-07-31.
//

import SwiftUI
import Observation

@Observable
class SidebarListViewModel {
    public var selectedMainTab: SidebarMainTabs? = .home

    public func getIcon(for tab: SidebarMainTabs) -> Image {
        switch tab {
            case .home:
                Image(systemName: "house")
            case .search:
                Image(systemName: "magnifyingglass")
            case .pinned:
                Image(systemName: "pin")
            case .bookmarks:
                Image(systemName: "bookmark")
        }
    }
}
