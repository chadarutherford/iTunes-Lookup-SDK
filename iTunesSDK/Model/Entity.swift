//
//  Entity.swift
//  iTunesSDK
//
//  Created by Fernando Olivares on 2/13/20.
//  Copyright © 2020 Quetzal. All rights reserved.
//

import Foundation

enum Entity : String {
    // Movie
    case movieArtist
    case movie
    
    // Podcast
    case podcastAuthor
    case podcast
    
    // Music
    case music
    case musicArtist
    case musicTrack
    case album
    case musicVideo
    case mix
    // Can include both songs and music video in the results.
    case song
    
    // Audiobook
    case audiobookAuthor
    case audiobook
    
    // ShortFilm
    case shortFilmArtist
    case shortFilm

    // TV Show
    case tvEpisode
    case tvSeason
    
    // Software
    case software
    case iPadSoftware
    case macSoftware
    
    // E-Book
    case eBook
    
    // All
    case allArtist
    case allTrack
}

extension Entity {
    
    var urlParameter: String {
        return "&entity=\(self.rawValue)"
    }
}
