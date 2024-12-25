//
//  NewPageOverlayView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-25.
//

import SwiftUI

struct NewPageOverlayView: View {
    
    @State private var primaryVM = PrimaryVM.instance
    @State private var newPageOverlayVM = NewPageOverlayVM.instance
    
    var body: some View {
        NavigationStack {
            List {
                
                Section("Add New Page to...") {
                    Picker("Add Page to...", selection: $newPageOverlayVM.selectedPageAddLocation) {
                        Text("Before").tag(0)
                        Text("After").tag(1)
                        Text("Very End").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                
                Section("Templates") {
                    TemplateSelectorView(templatesList: primaryVM.templatesThumbnails, pageType: .writingPage)
                    Button(action: {}) {
                        Label("Import Templates...", systemImage: "square.and.arrow.down")
                    }
                }
            }
            .navigationTitle(Text("Add New Page"))
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.grouped)
        }
    }
}

#Preview {
    NewPageOverlayView()
}
