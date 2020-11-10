//
//  DrinkDetailViewModel.swift
//  CocktailSearch
//
//  Created by Andy Bell on 05.11.20.
//

import Foundation

protocol DrinkDetailViewModel {
    var drinkTitle: String { get }
    var drinkImageUrl: URL? { get }
    var drinkInstructionsStr: String { get }
    var drinkDescription: String { get }
}

class DrinkDetailViewModelDefault: DrinkDetailViewModel {
    
    var drinkImageUrl: URL? {
        guard let urlStr = drink.thumbnailUrl else {
            return nil
        }
        return URL(string: urlStr)
    }
    
    var drinkInstructionsStr: String {
        
        var instructionStr = ""
        drink.ingredients.forEach { _, val in
            instructionStr += "- \(val.measure) \(val.name)\n"
        }
        if let instr = drink.instructions {
            instructionStr += "\n\n" + instr
        }
        return instructionStr
    }
    
    var drinkDescription: String {
        return drink.category
    }
    
    var drinkTitle: String {
        return drink.name
    }
    
    private let drink: Drink
    
    init(drink: Drink) {
        self.drink = drink
    }
}
