//
//  DrinkModelTests.swift
//  CocktailSearchTests
//
//  Created by Andy Bell on 04.11.20.
//

import XCTest
@testable import CocktailSearch

class DrinkModelTests: XCTestCase {

    func test_drinkInt_returnsExpectedResults() throws {
        
        let mockData = try StubDataTestHelper.loadMockJsonData(for: "cocktail")
        let mockDrink = try JSONDecoder().decode(Drink.self, from: mockData)
    
        XCTAssertEqual(mockDrink.name, "Old Pal")
        XCTAssertEqual(mockDrink.instructions, "Chill cocktail glass. Add ingredients to a mixing glass, and fill 2/3 full with ice. Stir about 20 seconds. Empty cocktail glass and strain into the glass. Garnish with a twist of lemon peel.")
        XCTAssertEqual(mockDrink.category, "Cocktail")
        XCTAssertEqual(mockDrink.thumbnailUrl, "https://www.thecocktaildb.com/images/media/drink/x03td31521761009.jpg")
        XCTAssertEqual(mockDrink.isAlcoholic, true)
        
        XCTAssertEqual(mockDrink.ingredients.count, 3)
        XCTAssertEqual(mockDrink.ingredients[1]?.name, "Rye whiskey")
        XCTAssertEqual(mockDrink.ingredients[2]?.name, "Campari")
        XCTAssertEqual(mockDrink.ingredients[3]?.name, "Dry Vermouth")
        
        XCTAssertEqual(mockDrink.ingredients[1]?.measure, "2 oz")
        XCTAssertEqual(mockDrink.ingredients[2]?.measure, "1 oz")
        XCTAssertEqual(mockDrink.ingredients[3]?.measure, "1 oz")
    }
}
