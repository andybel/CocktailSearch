//
//  DrinkDetailCoordinator.swift
//  CocktailSearch
//
//  Created by Andy Bell on 05.11.20.
//

import UIKit

class DrinkDetailCoordinator: Coordinator {

    weak var parentCoordinator: MainCoordinator?

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    private let drink: Drink

    init(navigationController: UINavigationController, drink: Drink) {
        self.navigationController = navigationController
        self.drink = drink
    }

    func start() {
        let vc = DrinkDetailViewController.instantiate()
        let vm = DrinkDetailViewModelDefault(drink: drink)
        vc.viewModel = vm
        navigationController.pushViewController(vc, animated: true)
    }
}

