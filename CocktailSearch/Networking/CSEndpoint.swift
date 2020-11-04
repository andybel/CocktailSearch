//
//  CSEndpoint.swift
//  CocktailSearch
//
//  Created by Andy Bell on 18.10.20.
//

import Foundation

enum CSEndpoint {
    case search(String)

    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let searchTerm):
            let encodedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            return [URLQueryItem(name: "suchbegriff", value: encodedTerm)]
        }
    }
    
    var url: URL? {
        
        var term = ""
        switch self {
        case .search(let searchTerm):
            term = searchTerm
        }
        
        // thecocktaildb.com/api/json/v1/1/search.php?s=margarita
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.thecocktaildb.com"
        components.path = "/api/json/v1/1/search.php"
        components.queryItems = [URLQueryItem(name: "s", value: term)]
        return components.url
    }
    
//    var urlRequest: URLRequest? {
//        
//        guard let url = url else {
//            return nil
//        }
//        var request = URLRequest(url: url)
////        request.setValue("crosschannelapp", forHTTPHeaderField: "X-ClientName")
////        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
//        return request
//    }
}
