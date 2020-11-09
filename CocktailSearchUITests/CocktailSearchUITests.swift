//
//  CocktailSearchUITests.swift
//  CocktailSearchUITests
//
//  Created by Andy Bell on 04.11.20.
//

import XCTest

class CocktailSearchUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testMockSearchDisplaysExpected() throws {
        
        // PRE-INPUT
        let statusText = app.staticTexts["current_status_label"].label
        XCTAssertEqual(statusText, "Use the input field above to search for cocktails")
        
        app.textFields["Search cocktails"].tap()
        
        app.keys["t"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // RESULT CELLS
        let topCell = app.tables.element(boundBy: 0).cells.element(boundBy: 0)
        
        let cellTitleText = topCell.staticTexts["drink_cell_title_label"].label
        XCTAssertEqual(cellTitleText, "Old Pal")
        let cellAuthorText = topCell.staticTexts["drink_cell_author_label"].label
        XCTAssertEqual(cellAuthorText, "Cocktail")
        
        topCell.tap()
        
        // DETAIL
        let titleText = app.staticTexts["drink_title_label"].label
        XCTAssertEqual(titleText, "Old Pal")
        
        let descText = app.staticTexts["drink_description_label"].label
        XCTAssertEqual(descText, "Cocktail")
        
        let instructionsText = app.staticTexts["drink_instructions_label"].label
        XCTAssertEqual(instructionsText, "Chill cocktail glass. Add ingredients to a mixing glass, and fill 2/3 full with ice. Stir about 20 seconds. Empty cocktail glass and strain into the glass. Garnish with a twist of lemon peel.")
    }
}
