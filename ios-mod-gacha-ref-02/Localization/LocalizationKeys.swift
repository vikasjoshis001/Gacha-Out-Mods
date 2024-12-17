//
//  LocalizationKeys.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 04/12/24.
//

import Foundation

/* Store all localizable string constants used in the app */
class LocalizationKeys {
    
    // MARK: - Common
    static var ok: String { return "ok".localized() }
    static var download: String { return "download".localized() }
    static var open: String { return "open".localized() }
    static var yes: String { return "yes".localized() }
    static var no: String { return "no".localized() }

    // MARK: - LaunchScreen
    static var waitALittleBit: String { return "wait_a_little_bit".localized() }
    static var noInternetConnection: String { return "no_internet_connection".localized() }
    
    // MARK: - MenuBar
    static var wallpapers_MGRE: String { return "wallpapers_MGRE".localized() }
    static var mods_MGRE: String { return "mods_MGRE".localized() }
    static var characters_MGRE: String { return "characters_MGRE".localized() }
    static var collections_MGRE: String { return "collections_MGRE".localized() }
    static var editor_MGRE: String { return "editor_MGRE".localized() }
    static var outfitIdeas_MGRE: String { return "outfitIdeas_MGRE".localized() }
    static var favorites_MGRE: String { return "favorites_MGRE".localized() }
    
    // MARK: - NavBar
    static var all_MGRE: String { return "all_MGRE".localized() }
    static var new_MGRE: String { return "new_MGRE".localized() }
    static var top_MGRE: String { return "top_MGRE".localized() }
    
    // MARK: - Editor
    static var createNewCharacter_MGRE: String { return "create_new_character".localized() }
    static var emptyCharactersMsg: String { return "empty_characters_msg".localized() }
    static var cancelAllSettings: String { return "cancel_all_settings".localized() }
}
