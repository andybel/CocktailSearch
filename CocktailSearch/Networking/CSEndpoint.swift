//
//  CSEndpoint.swift
//  CocktailSearch
//
//  Created by Andy Bell on 18.10.20.
//

import Foundation

enum CSEndpoint {
    case search(String)
    case searchFirstLetter(String)

    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let searchTerm):
            return [URLQueryItem(name: "s", value: searchTerm)]
        case .searchFirstLetter(let searchLetter):
            return [URLQueryItem(name: "f", value: searchLetter)]
        }
    }
    
    var url: URL? {
        
//        var term = ""
//        switch self {
//        case .search(let searchTerm):
//            term = searchTerm
//        }
        
        // thecocktaildb.com/api/json/v1/1/search.php?s=margarita
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.thecocktaildb.com"
        components.path = "/api/json/v1/1/search.php"
        components.queryItems = queryItems
        return components.url
    }
}
