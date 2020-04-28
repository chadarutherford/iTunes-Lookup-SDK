//
//  Lookup.swift
//  iTunesSDK
//
//  Created by Fernando Olivares on 2/16/20.
//  Copyright © 2020 Quetzal. All rights reserved.
//

import Foundation

struct Lookup {
	
	private let base: Base
	
	private let mediaType: MediaType?
	private let entity: Entity?
	private let limit: Int?
	private let languageCode: String?
	private let explicitContentAllowed: Bool?
	
	init(base: Base,
		 mediaType: MediaType? = nil,
		 entity: Entity? = nil,
		 limit: Int? = nil,
		 languageCode: String? = nil,
		 explicitContentAllowed: Bool? = nil) {
		
		self.base = base
		self.mediaType = mediaType
		self.entity = entity
		self.limit = limit
		self.languageCode = languageCode
		self.explicitContentAllowed = explicitContentAllowed
	}
}

// MARK: - URL creation
extension Lookup {
	
	func lookupURL(baseURLString: String) -> URL? {
		
		var mutableBaseURLString = baseURLString + base.urlParameter
		
		if let mediaType = mediaType {
			mutableBaseURLString.append(mediaType.urlParameter)
		}
		
		if let entity = entity {
			mutableBaseURLString.append(entity.urlParameter)
		}
		
		if let limit = limit {
			mutableBaseURLString.append("&limit=\(limit)")
		}
		
		if let languageCode = languageCode {
			mutableBaseURLString.append("&languageCode=\(languageCode)")
		}
		
		if let explicitFlag = explicitContentAllowed {
			let explicitFlagURL = explicitFlag ? "Yes" : "No"
			mutableBaseURLString.append("&explicitFlag=\(explicitFlagURL)")
		}
		
		return URL(string: mutableBaseURLString)
	}
}

// MARK: - Base
extension Lookup {
	
	// For all lookup types check API source code.
	// See https://github.com/mdewilde/itunes-api/blob/master/src/main/java/be/ceau/itunesapi/Lookup.java
    enum Base {
        
        case isbn(String)
        case itunesID(String)
        case upc(String) // Universal Product Code
		case amg(AMGType) // All Music Guide
		
		enum AMGType {
			case artist(String)
			case album(String)
			case video(String)
			
			var stringValue: String {
				switch self {
				case .artist(let value),
					 .album(let value),
					 .video(let value):
					return value
				}
			}
			
			var urlParameterKey: String {
				switch self {
				case .artist: return "amgArtistId"
				case .album: return "amgAlbumId"
				case .video: return "amgVideoId"
				}
			}
		}
        
        var urlParameter: String {
            switch self {
                
            case .isbn(let isbn):
                return "isbn=\(isbn)"
                
            case .itunesID(let id):
                return "?id=\(id)"
                
            case .upc(let upc):
                return "?upc=\(upc)"
                
            case .amg(let type):
				return "?\(type.urlParameterKey)=\(type.stringValue)"
            }
        }
    }
}
