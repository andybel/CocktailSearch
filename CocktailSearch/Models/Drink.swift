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

struct Ingredient: Equatable, Hashable {
    let name: String
    let measure: String
}

struct Drink: Codable, Hashable {
    let name: String
    let instructions: String?
    let category: String
    let isAlcoholic: Bool?
    let thumbnailUrl: String?
    let ingredients: [Int: Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case instructions = "strInstructions"
        case category = "strCategory"
        case isAlcoholic = "strAlcoholic"
        case thumbnailUrl = "strDrinkThumb"
    }
    
    private struct DynamicCodingKeys: CodingKey {
        
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        category = try container.decode(String.self, forKey: .category)
        thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
        
        if let isAlcoholicStr = try? container.decode(String.self, forKey:  .isAlcoholic) {
            isAlcoholic = (isAlcoholicStr == "Alcoholic")
        } else {
            isAlcoholic = nil
        }
        
        
        let ingredientsContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        var ingredValsDict = [Int: String]()
        var measuresDict = [Int: String]()
        
        for key in ingredientsContainer.allKeys {

            if let key = DynamicCodingKeys(stringValue: key.stringValue),
               let decodedObject = try? ingredientsContainer.decode(String.self, forKey: key),
               let idAsStr = key.stringValue.parseToInt() {
                
                if key.stringValue.contains("strIngredient") {
                    ingredValsDict[idAsStr] = decodedObject
                } else if key.stringValue.contains("strMeasure") {
                    measuresDict[idAsStr] = decodedObject
                }
            }
        }
        
        var ingredientsDict = [Int: Ingredient]()
        ingredValsDict.forEach { (key, val) in
            ingredientsDict[key] = Ingredient(name: val, measure: measuresDict[key] ?? "n/a")
        }
        
        ingredients = ingredientsDict
    }
}
