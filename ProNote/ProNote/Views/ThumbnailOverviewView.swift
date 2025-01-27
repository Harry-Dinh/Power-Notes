//
//  ThumbnailOverviewView.swift
//  ProNote
//
//  Created by Harry Dinh on 2025-01-01.
//

import SwiftUI
import PDFKit

struct ThumbnailOverviewView: View {
    @Environment(\.dismiss) var dismissModal
    
    var body: some View {
        NavigationStack {
            DocumentOverviewView()
                .padding(.top)
                .navigationTitle("All Pages")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Done") {
                            dismissModal.callAsFunction()
                        }
                    }
                }
        }
    }
}
