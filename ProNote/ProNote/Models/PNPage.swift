//
//  PNPage.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-16.
//

import Foundation
import PencilKit

struct PNPage: Identifiable {
    var id: String
    var dimension: CGSize
    var annotation: PKDrawing
    var isBookmarked: Bool
    var outlineName: String
    
    /// Create a new empty page
    init() {
        self.id = UUID().uuidString
        self.dimension = CGSize(width: PNConstants.DEFAULT_PAGE_WIDTH, height: PNConstants.DEFAULT_PAGE_HEIGHT)     // This should create a 8.5" x 11" paper
        self.annotation = PKDrawing()
        self.isBookmarked = false
        self.outlineName = ""
    }
    
    /// Create a new PNPage object from existing data
    init(_ id: String, _ dimension: CGSize, _ annotation: PKDrawing, _ isBookmarked: Bool, _ outlineName: String) {
        self.id = id
        self.dimension = dimension
        self.annotation = annotation
        self.isBookmarked = isBookmarked
        self.outlineName = outlineName
    }
    
    public static let PLACEHOLDER = PNPage("NCC-1701", CGSize(width: PNConstants.DEFAULT_PAGE_WIDTH, height: PNConstants.DEFAULT_PAGE_HEIGHT), PKDrawing(), false, "")
}
