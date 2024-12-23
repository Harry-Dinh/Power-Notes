//
//  TemplateSelectorView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-23.
//

import SwiftUI

struct TemplateSelectorView: View {
    
    private var templatesList: [UIImage]
    @State private var noteCreationVM = NoteCreationVM.instance
    
    init(templatesList: [UIImage]) {
        self.templatesList = templatesList
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(0..<templatesList.count) { i in
                    Image(uiImage: templatesList[i])
                        .resizable()
                        .border(.tertiary, width: 1)
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .padding(.vertical)
                        .onTapGesture {
                            // Assign the preview at the top to let the user see the selected template
                            noteCreationVM.selectedTemplate = templatesList[i]
                            
                            // This is used for selecting the URL for the selected PDF from the array inside PrimaryVM
                            noteCreationVM.selectedTemplateIndex = i
                        }
                }
            }
        }
    }
}

#Preview {
    NoteCreationView()
}
