//
//  HomepageView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-16.
//

import SwiftUI

struct HomepageView: View {
    var body: some View {
        NavigationStack {
            List {
                
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Menu {
                        Button(action: {}) {
                            Label("New Quick Note", systemImage: "doc")
                        }
                        
                        Button(action: {}) {
                            Label("New Notebook...", systemImage: "text.book.closed")
                        }
                        
                        Divider()
                        
                        Button(action: {}) {
                            Label("New Folder...", systemImage: "folder")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                    Menu {
                        EditButton()
                        Divider()
                        Button(action: {}) {
                            Label("Settings", systemImage: "gear")
                        }
                        
                        Button(action: {}) {
                            Label("Feedback...", systemImage: "ellipsis.bubble")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .symbolVariant(.circle)
                    }
                }
            }
        }
    }
}

#Preview {
    HomepageView()
}
