//
//  LocalizationKeys.swift
//  ios-mod-gacha-ref-02
//
//  Created by Vikas Joshi on 04/12/24.
//

import Foundation

/* Store all localizable string constants used in the app */
enum LocalizationKeys {
    // MARK: - Common

    static var ok: String { return "ok".localized() }
    static var download: String { return "download".localized() }
    static var open: String { return "open".localized() }
    static var yes: String { return "yes".localized() }
    static var no: String { return "no".localized() }
    static var ready: String { return "ready".localized() }

    // MARK: - LaunchScreen

    static var waitALittleBit: String { return "wait_a_little_bit".localized() }
    static var noInternetConnection: String { return "no_internet_connection".localized() }

    // MARK: - MenuBar

    static var wallpapers: String { return "wallpapers".localized() }
    static var mods: String { return "mods".localized() }
    static var characters: String { return "characters".localized() }
    static var collections: String { return "collections".localized() }
    static var editor: String { return "editor".localized() }
    static var outfitIdeas: String { return "outfitIdeas".localized() }
    static var favorites: String { return "favorites".localized() }

    // MARK: - NavBar

    static var all: String { return "all".localized() }
    static var new: String { return "new".localized() }
    static var top: String { return "top".localized() }

    // MARK: - Editor

    static var createNewCharacter_MGRE: String { return "create_new_character".localized() }
    static var emptyCharactersMsg: String { return "empty_characters_msg".localized() }
    static var cancelAllSettings: String { return "cancel_all_settings".localized() }
}
