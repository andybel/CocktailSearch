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
    private var fetchInProgress = false
    
    var searchInput: String? = nil {
        didSet {
            let newInputValid = searchInput != nil && searchInput!.count > 1
            if newInputValid != inputIsValid {
                inputIsValid = newInputValid
                validInputUpdated(inputIsValid)
            }
            
            if searchInput?.count == 1 && drinks.isEmpty {
                submitSearch()
            } else if searchInput?.count == 0 {
                // TODO: keep current drinks in memory in case user submits the same letter again?
                drinks = []
                didUpdate(drinks)
            } else if let input = searchInput {
                let filteredDrinks = drinks.filter { $0.name.lowercased().contains(input.lowercased()) }
                didUpdate(filteredDrinks)
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
        
        if let searchInput = self.searchInput, searchInput.count > 1 {
            let filteredDrinks = drinks.filter { $0.name.lowercased().contains(searchInput.lowercased()) }
            listDidSelectDrink(filteredDrinks[index])
        } else {
            listDidSelectDrink(drinks[index])
        }
    }
    
    func submitSearch() {
        
        guard fetchInProgress == false, let term = searchInput, !term.isEmpty else {
            didError(CSError.emptyInput)
            return
        }
        fetchInProgress = true
        
        let endpoint: CSEndpoint = term.count == 1 ? .searchFirstLetter(term) : .search(term)
    
        searchService.fetchResults(for: endpoint) { [weak self] result in

            guard let self = self else { return }
            
            self.fetchInProgress = false
            
            switch result {
            case .success(let drinks):
                self.drinks = drinks
                guard !drinks.isEmpty else {
                    self.didError(CSError.requestReturnedEmpty)
                    return
                }
                
                if let searchInput = self.searchInput, searchInput.count > 1 {
                    let filteredDrinks = drinks.filter { $0.name.lowercased().contains(searchInput.lowercased()) }
                    self.didUpdate(filteredDrinks)
                } else {
                    self.didUpdate(drinks)
                }
                
            case .failure(let error):
                self.didError(error)
            }
        }
    }
}
