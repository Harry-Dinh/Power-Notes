//
//  NoteEditingViewModel.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-30.
//

import Foundation
import PencilKit

@Observable
class NoteEditingViewModel {
    var currentNote: PNNote?
    
    var showEditingView = false
    var isToolkitVisible = true
    var selectedTool: PNWritingTool?
    
    let tools: [PNWritingTool] = [
        PNWritingTool(
            toolType: .fountainPen,
            pkTool: PKInkingTool(ink: PKInk(.pen, color: .black), width: 30)
        ),
        PNWritingTool(
            toolType: .highlighter,
            pkTool: PKInkingTool(ink: PKInk(.marker), width: 30)
        ),
        PNWritingTool(
            toolType: .eraser,
            pkTool: PKEraserTool(.vector)
        ),
        PNWritingTool(
            toolType: .lasso,
            pkTool: PKLassoTool()
        )
    ]
    
    func open(_ note: PNNote) {
        currentNote = note
        showEditingView = true
    }
    
    func cleanUpBeforeDismiss() {
        currentNote = nil
    }
}
