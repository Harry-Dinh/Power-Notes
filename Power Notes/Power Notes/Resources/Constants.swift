//
//  Constants.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-05-14.
//

import Foundation
import PencilKit

final class Constants {
    static let inboxFolderUUID = UUID(uuidString: "PWRNOTE-INBOX-UUID") ?? UUID()
    
    // MARK: - UserDefaults Keys
    
    static let storedSelectedSidebarItemID = "storedSelectedSidebarItemID"
    
    // MARK: - PDF Page Templates Specs
    
    static let letterSizePortraitPaper = CGSize(width: 612, height: 792)
    
    // MARK: - Other Stuff
    
    static let defaultSelectedTool = PKInkingTool(ink: PKInk(.pen, color: .black), width: 30)
}
