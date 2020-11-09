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
        return drink.instructions ?? "-"
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
