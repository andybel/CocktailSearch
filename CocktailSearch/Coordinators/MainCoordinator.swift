//
//  MainCoordinator.swift
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = DrinksListViewController.instantiate()

        var searchService: SearchService = SearchServiceDefault()
//        if CommandLine.arguments.contains("enable-testing") {
//            searchService = MockSearchService()
//        }

        let drinksListViewModel = DrinksListViewModelDefault(searchService: searchService)
        drinksListViewModel.listDidSelectDrink = { [weak self] drink in
            self?.displayDetail(for: drink)
        }
        vc.viewModel = drinksListViewModel

        navigationController.pushViewController(vc, animated: false)
    }
    
    private func displayDetail(for drink: Drink) {
//        let child = ProductDetailCoordinator(navigationController: navigationController, product: product)
//        child.parentCoordinator = self
//        childCoordinators.append(child)
//        child.start()
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {

//        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from),
//            navigationController.viewControllers.contains(fromVC),
//            let productDetailVC = fromVC as? ProductDetailViewController else {
//                return
//        }
//        childDidFinish(productDetailVC.coordinator)
    }
}
