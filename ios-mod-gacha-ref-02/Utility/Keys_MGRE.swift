//
//  Keys_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import Foundation

struct Keys_MGRE {
    
    enum Path_MGRE: String {
        case editor_mgre = "content/6737730eab005/content",
             mods_mgre = "content/6737730ea7e31/content",
             outfitIdeas_mgre = "content/673773360eb16/content",
             characters_mgre = "content/6737734a3d155/content",
             collections_mgre = "content/673773184087f/content",
             wallpapers_mgre = "content/6737731c09cad/content"
    
        
        var contentPath: String {
            .init(format: "/%@.json", rawValue, rawValue)
        }
    }
    
    enum App_MGRE: String {
        case accessCode_MGRE = "czHFetFkAxAAAAAAAAAEa9vA6-b2vQg6uNF-pEhsRBU",
             link_MGRE = "https://api.dropboxapi.com/oauth2/token",
             secret_MGRE = "5mqr8urnnba1hyj",
             key_MGRE = "hk15jpjilosy7e8"
    }
    
    enum ImagePath_MGRE {
        static let editor_mgre = "content/6737730eab005/"
        static let mods_mgre = "content/6737730ea7e31/"
        static let outfitIdeas_mgre = "content/673773360eb16/"
        static let characters_mgre = "content/6737734a3d155/"
        static let collections_mgre = "content/673773184087f/"
        static let wallpapers_mgre = "content/6737731c09cad/"
    }
}
