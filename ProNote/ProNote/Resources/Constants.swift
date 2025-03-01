//
//  Constants.swift
//  ProNote
//
//  Created by Harry Dinh on 2024-11-16.
//

import Foundation

final class PNConstants {
    static let DEFAULT_PAGE_WIDTH = 612
    static let DEFAULT_PAGE_HEIGHT = 792
    static let NOTE_VIEW_GRID_DIMENSION: CGFloat = 200
    static let COLOR_BUTTON_DIMENSION: CGFloat = 25
    static let USER_DEFAULT = UserDefaults.standard
}

enum TemplateType {
    case writingPage
    case frontCover
}

/// A class containing a bunch of keys for items that are stored in local storage with `UserDefaults`.
final class UDKeys {
    static let FOUNTAIN_PEN_PALETTE = "fountainPenPalette"
    static let HIGHLIGHTER_PALETTE = "highlighterPalette"
    static let PENCIL_PALETTE = "pencilPalette"
}
