//
//  String+parseAsInt.swift
//  CocktailSearch
//
//  Created by Andy Bell on 10.11.20.
//

import Foundation

extension String {
    func parseToInt() -> Int? {
        return Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}
