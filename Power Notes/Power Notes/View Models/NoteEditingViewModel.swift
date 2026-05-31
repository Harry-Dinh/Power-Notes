//
//  NoteEditingViewModel.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-30.
//

import Foundation

@Observable
class NoteEditingViewModel {
    var currentNote: PNNote?
    
    var showEditingView = false
    
    func open(_ note: PNNote) {
        currentNote = note
        showEditingView = true
    }
    
    func cleanUpBeforeDismiss() {
        currentNote = nil
    }
}
