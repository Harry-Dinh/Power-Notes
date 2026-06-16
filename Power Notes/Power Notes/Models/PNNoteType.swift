//
//  PNNoteType.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-31.
//

enum PNNoteType: Codable {
    /// This note is a handwritten notes with a PDF background and annotation data.
    case handwritten
    
    /// This note is a typed note with the content being a Markdown string.
    case typed
}
