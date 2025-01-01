//
//  ThumbnailPreviewView.swift
//  ProNote
//
//  Created by Harry Dinh on 2025-01-01.
//

import SwiftUI

struct ThumbnailPreviewView: View {
    
    var thumbnail: UIImage
    var indexNumber: Int
    
    var body: some View {
        VStack {
            Image(uiImage: thumbnail)
                .resizable()
                .border(.tertiary, width: 1)
                .scaledToFit()
                .frame(width: 150, height: 150)
                .onTapGesture {
                    // TODO: Jump to that page! (Hint: Manipulate its index number)
                }
            
            // MARK: Index number and actions
            HStack(spacing: 70) {
                Text("\(indexNumber + 1)")
                    .font(.footnote)
                
                Menu {
                    Button(action: {}) {
                        Label("Add to Outline...", systemImage: "list.bullet.indent")
                    }
                    
                    Button(action: {}) {
                        Label("Bookmark Page", systemImage: "bookmark")
                    }
                    
                    Menu {
                        Button(action: {}) {
                            Label("Beginning", systemImage: "arrow.up.doc")
                        }
                        
                        Button(action: {}) {
                            Label("End", systemImage: "arrow.down.doc")
                        }
                    } label: {
                        Text("New Page At...")
                    }
                    
                    Divider()
                    
                    Button(role: .destructive) {
                        
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
    }
}

#Preview {
    ThumbnailPreviewView(thumbnail: UIImage(systemName: "doc")!, indexNumber: 69)
}
