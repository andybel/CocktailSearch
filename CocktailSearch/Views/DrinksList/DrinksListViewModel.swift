//
//  DrinksListViewModel.swift
//  CocktailSearch
//
//  Created by Andy Bell on 04.11.20.
//

import Foundation

protocol DrinksListViewModel {
    func submitSearch()
    func selectItem(at index: Int)
    var searchInput: String? { get set }
    var validInputUpdated: ((_ isValid: Bool) -> Void) { get set }
    var didUpdate: ((_ products: [Drink]) -> Void) { get set }
    var didError: ((_ error: Error) -> Void) { get set }
}

final class DrinksListViewModelDefault: DrinksListViewModel {
    
    public var listDidSelectDrink: ((_: Drink) -> Void) = { _ in }
    
    private var inputIsValid = false
    private var drinks = [Drink]()
    
    var searchInput: String? = nil {
        didSet {
            let newInputValid = searchInput != nil && searchInput!.count > 1
            if newInputValid != inputIsValid {
                inputIsValid = newInputValid
                validInputUpdated(inputIsValid)
            }
        }
    }
    var validInputUpdated: ((Bool) -> Void) = { _ in }
    var didUpdate: (([Drink]) -> Void) = { _ in }
    var didError: ((Error) -> Void) = { _ in }
    
    private let searchService: SearchService
    
    init(searchService: SearchService) {
        self.searchService = searchService
    }
    
    // MARK: protocol publics
    func selectItem(at index: Int) {
        let selectedDrink = drinks[index]
        listDidSelectDrink(selectedDrink)
    }
    
    func submitSearch() {
        
        guard let term = searchInput, !term.isEmpty else {
            didError(CSError.emptyInput)
            return
        }
        
        searchService.fetchResults(for: .search(term)) { [weak self] result in

            guard let self = self else { return }
            switch result {
            case .success(let drinks):
                self.drinks = drinks
                guard !drinks.isEmpty else {
                    self.didError(CSError.requestReturnedEmpty)
                    return
                }
                self.didUpdate(drinks)
            case .failure(let error):
                self.didError(error)
            }
        }
    }
}
