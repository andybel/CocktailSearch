//
//  DrinkDetailViewController.swift
//  CocktailSearch
//
//  Created by Andy Bell on 05.11.20.
//

import UIKit

class DrinkDetailViewController: UIViewController, Storyboarded {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    public weak var coordinator: DrinkDetailCoordinator?
    var viewModel: DrinkDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.accessibilityIdentifier = "drink_title_label"
        descriptionLabel.accessibilityIdentifier = "drink_description_label"
        instructionsLabel.accessibilityIdentifier = "drink_instructions_label"
        
        if let url = viewModel.drinkImageUrl {
            imageView.loadImage(at: url)
        }
        titleLabel.text = viewModel.drinkTitle
        descriptionLabel.text = viewModel.drinkDescription
        instructionsLabel.text = viewModel.drinkInstructionsStr
        
        // TODO: put this in scroller
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    deinit {
        print("===== deinit DrinkDetailViewController =====")
    }
}
