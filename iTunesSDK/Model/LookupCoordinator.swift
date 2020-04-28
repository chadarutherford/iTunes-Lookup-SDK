//
//  LookupCoordinator.swift
//  iTunesSDK
//
//  Created by Fernando Olivares on 2/13/20.
//  Copyright © 2020 Quetzal. All rights reserved.
//

import Foundation

import UIKit

class LookupCoordinator {
    
    private let baseURLString: String
	
	init() {
		baseURLString = "https://itunes.apple.com/lookup"
	}
	
    init(baseURLString: String) {
        self.baseURLString = baseURLString
    }
    
	enum LookupError : Error {
        case invalidURL
        case dataTask(Error)
        case invalidServerResponse
        case unexpectedHTTPResponse(Int)
        case invalidStateMissingData
        case invalidStateCouldNotParseToJSON(Error)
    }
	func lookup(_ type: Lookup, completion: @escaping (Result<Any, LookupError>) -> Void) {
		
        guard let preparedURL = type.lookupURL(baseURLString: baseURLString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let lookupTask = URLSession.shared.dataTask(with: preparedURL) { possibleData, possibleURLResponse, possibleError in
			
            guard possibleError == nil else {
                completion(.failure(.dataTask(possibleError!)))
                return
            }
            
            guard let httpResponse = possibleURLResponse as? HTTPURLResponse else {
                completion(.failure(.invalidServerResponse))
                return
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                completion(.failure(.unexpectedHTTPResponse(httpResponse.statusCode)))
                return
            }
            
            guard let data = possibleData else {
                completion(.failure(.invalidStateMissingData))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                completion(.success(json))
            } catch {
                completion(.failure(.invalidStateCouldNotParseToJSON(error)))
            }
        }
        lookupTask.resume()
    }
}
