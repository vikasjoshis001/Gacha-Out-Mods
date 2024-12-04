//
//  Keys_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import Foundation

struct Keys_MGRE {
    
    enum Path_MGRE: String {
        case editor_mgre = "Editor",
             mods_mgre = "Mods",
             outfitIdeas_mgre = "Outfits_ideas",
             characters_mgre = "Characters",
             collections_mgre = "Mini-games",
             wallpapers_mgre = "Wallpapers"
        
        var contentPath: String {
            .init(format: "/%@.json", rawValue, rawValue)
        }
    }
    
    enum App_MGRE: String {
        case accessCode_MGRE = "czHFetFkAxAAAAAAAAAEa9vA6-b2vQg6uNF-pEhsRBU",
             link_MGRE = "https://api.dropboxapi.com/oauth2/token",
             secret_MGRE = "7l84hfluiyz2tlz",
             key_MGRE = "idlgxb0j79jxx08"
    }
}
