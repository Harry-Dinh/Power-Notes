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
    
    func cleanUpBeforeDismiss() {
        currentNote = nil
    }
}
