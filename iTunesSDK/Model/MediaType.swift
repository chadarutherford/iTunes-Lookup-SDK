//
//  MediaType.swift
//  iTunesSDK
//
//  Created by Fernando Olivares on 2/13/20.
//  Copyright © 2020 Quetzal. All rights reserved.
//

import Foundation

enum MediaType : String {
    case movie
    case podcast
    case music
    case musicVideo
    case audiobook
    case shortFilm
    case tvShow
    case software
    case eBook
    case all
}

extension MediaType {
    
    var urlParameter: String {
        return "&media=\(self.rawValue)"
    }
}
