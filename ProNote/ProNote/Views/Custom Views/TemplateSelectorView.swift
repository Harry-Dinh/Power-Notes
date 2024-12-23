//
//  TemplateSelectorView.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-12-23.
//

import SwiftUI

struct TemplateSelectorView: View {
    
    private var templatesList: [UIImage]
    private var pageType: TemplateType
    @State private var noteCreationVM = NoteCreationVM.instance
    
    init(templatesList: [UIImage], pageType: TemplateType) {
        self.templatesList = templatesList
        self.pageType = pageType
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
                            /*
                             1. Set the preview template at the top of the page
                             2. Set the page index to load the actual PDF file into the main edit view
                             */
                            
                            if pageType == .writingPage {
                                noteCreationVM.selectedTemplate = templatesList[i]
                                noteCreationVM.selectedTemplateIndex = i
                            } else {
                                noteCreationVM.selectedCover = templatesList[i]
                                noteCreationVM.selectedCoverIndex = i
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    NoteCreationView()
}
