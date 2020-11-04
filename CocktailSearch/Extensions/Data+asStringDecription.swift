//
//  Data+asStringDecription.swift
//  CocktailSearch
//
//  Created by Andy Bell on 18.10.20.
//

import Foundation

extension Data {
    
    func printAsString() {
        guard let asString = String(data: self, encoding: .utf8) else {
            print("unable to convert data to string representation")
            return
        }
        print("Data as string: \(asString)")
    }
}
