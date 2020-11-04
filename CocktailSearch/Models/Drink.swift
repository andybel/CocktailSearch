//
//  Drink.swift
//  CocktailSearch
//
//  Created by Andy Bell on 04.11.20.
//

import Foundation

struct ResponseWrapper: Decodable {
    var drinks: [Drink]
}

struct Drink: Codable, Hashable {
    let name: String
    let instructions: String?
    let category: String
    let isAlcoholic: String?
    let thumbnailUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case instructions = "strInstructions"
        case category = "strCategory"
        case isAlcoholic = "strAlcoholic"
        case thumbnailUrl = "strDrinkThumb"
    }
}
