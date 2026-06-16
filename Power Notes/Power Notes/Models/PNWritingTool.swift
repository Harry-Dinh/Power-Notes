//
//  PNWritingTools.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-06-05.
//

import PencilKit
import SwiftUI

enum PNWritingToolType: String {
    case fountainPen = "Fountain Pen"
    case highlighter = "Highlighter"
    case lasso = "Lasso"
    case eraser = "Eraser"
    case monolinePen = "Monoline Pen"
}

struct PNWritingTool: Identifiable {
    var id: String {
        toolType.rawValue
    }
    
    var toolType: PNWritingToolType
    var pkTool: PKTool?
    
    init(
        toolType: PNWritingToolType,
        pkTool: PKTool?
    ) {
        self.toolType = toolType
        self.pkTool = pkTool
    }
    
    static func icon(for toolType: PNWritingToolType) -> Image {
        switch toolType {
        case .fountainPen:
            return Image(_internalSystemName: "pen.pointed.nib.tip")
        case .highlighter:
            return Image(_internalSystemName: "highlighter.tip")
        case .lasso:
            return Image(_internalSystemName: "pencil.lasso.tip")
        case .eraser:
            return Image(_internalSystemName: "eraser.tip")
        case .monolinePen:
            return Image(_internalSystemName: "pen.monoliner.tip")
        }
    }
}
