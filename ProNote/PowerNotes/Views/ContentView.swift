//
//  ContentView.swift
//  PowerNotes
//
//  Created by Harry Dinh on 2025-07-31.
//

import SwiftUI

struct ContentView: View {
    @State private var parentViewModel = ParentViewModel()
    @State private var sidebarViewModel = SidebarListViewModel()

    var body: some View {
        NavigationSplitView {
            sidebarView
        } detail: {
            detailView
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        viewManipulationToolbarSection
                        newDocumentButton
                    }
                }
        }
    }

    // MARK: - Subviews

    private var sidebarView: some View {
        List(SidebarMainTabs.allCases, id: \.rawValue, selection: $sidebarViewModel.selectedMainTab) { tab in
            sidebarRowView(tab)
        }
        .navigationTitle("Power Notes")
    }

    private func sidebarRowView(_ tab: SidebarMainTabs) -> some View {
        NavigationLink(value: tab) {
            Label {
                Text(tab.rawValue)
            } icon: {
                sidebarViewModel.getIcon(for: tab)
            }
        }
    }

    @ViewBuilder
    private var detailView: some View {
        switch sidebarViewModel.selectedMainTab {
            case .home:
                Text("Home")
            case .search:
                Text("Search")
            case .pinned:
                Text("Pinned")
            case .bookmarks:
                Text("Bookmarks")
            case .none:
                EmptyView()
        }
    }

    // MARK: - Toolbar Subviews

    private var viewManipulationToolbarSection: some View {
        ControlGroup {
            viewModePicker
            selectButton
        }
    }

    private var viewModePicker: some View {
        Picker(selection: $parentViewModel.selectedViewMode) {
            ForEach(HomeViewMode.allCases, id: \.rawValue) { viewMode in
                Label {
                    Text(viewMode.rawValue)
                } icon: {
                    EnumManager.homeViewModeIcon(for: viewMode)
                }
                .tag(viewMode)
            }
        } label: {
            if parentViewModel.selectedViewMode == .list {
                EnumManager.homeViewModeIcon(for: .list)
            } else {
                EnumManager.homeViewModeIcon(for: .grid)
            }
        }
        .pickerStyle(.menu)
        .menuIndicator(.visible)
    }

    private var selectButton: some View {
        Button("Select") {}
    }

    private var newDocumentButton: some View {
        Button(action: {}) {
            Image(systemName: "square.and.pencil")
        }
    }
}

#Preview {
    ContentView()
}
