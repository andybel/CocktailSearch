//
//  DrinksListViewController.swift
//  CocktailSearch
//
//  Created by Andy Bell on 04.11.20.
//

import UIKit

class DrinksListViewController: UIViewController, Storyboarded, TableViewUpdatable {

    @IBOutlet var submitButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var statusView: ListStatusView!
    
    private lazy var drinksDataSource = makeDrinksDataSource()
    
    var viewModel: DrinksListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = NSLocalizedString("product_search", comment: "ProductList main title")
        
        tableView.dataSource = drinksDataSource
        configureViewModel()
        configureStateForInitialUIElements()
        configureInitialStatusView()
    }

    // MARK: IBActions
    @IBAction func submitButtonAction(_ sender: Any) {

        statusView.configure(with: .loadingData)
        statusView.isHidden = false
        viewModel.submitSearch()
        searchTextField.text = ""
        searchTextField.resignFirstResponder()
        configureSubmitButtonState(enabled: false)
    }
    
    @objc func didUpdateSearchInputText(_ sender: UITextField) {
        viewModel.searchInput = sender.text
    }

    // MARK: private
    private func configureViewModel() {
        
        viewModel.validInputUpdated = { [weak self] isValid in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.configureSubmitButtonState(enabled: isValid)
            }
        }

        viewModel.didUpdate = { [weak self] products in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.statusView.isHidden = true
                self.updateDataSource(self.drinksDataSource, withItems: products, animated: true)
            }
        }

        viewModel.didError = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.statusView.configure(with: error)
                self.statusView.isHidden = false
            }
        }
    }
    
    private func configureStateForInitialUIElements() {
        
        configureSubmitButtonState(enabled: false)
        
        submitButton.accessibilityLabel = NSLocalizedString("search", comment: "text for search button")
        submitButton.setTitle(NSLocalizedString("search", comment: "text for search button"), for: .normal)
        
        searchTextField.accessibilityLabel = NSLocalizedString("search_products", comment: "The search input field placeholder")
        searchTextField.placeholder = NSLocalizedString("search_products", comment: "The search input field placeholder")
        searchTextField.addTarget(self, action: #selector(didUpdateSearchInputText(_:)), for: .editingChanged)
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.delegate = self
    }
    
    private func configureInitialStatusView() {
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusView)
        NSLayoutConstraint.activate([
            statusView.leftAnchor.constraint(equalTo: tableView.leftAnchor),
            statusView.rightAnchor.constraint(equalTo: tableView.rightAnchor),
            statusView.topAnchor.constraint(equalTo: tableView.topAnchor),
            statusView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
        statusView.configure(with: .awaitingInput)
    }
    
    private func configureSubmitButtonState(enabled: Bool) {
        submitButton.isEnabled = enabled
        submitButton.alpha = enabled ? 1.0 : 0.3
    }
    
    private func makeDrinksDataSource() -> UITableViewDiffableDataSource<Section, Drink> {

        let reuseIdentifier = "cell"

        return UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, drink in

            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? DrinkCell else {
                fatalError("failed to dequeue DrinkCell")
            }
            cell.selectionStyle = .none
            cell.configure(with: drink)
            return cell
        }
    }
}

extension DrinksListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath.row)
    }
}

extension DrinksListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        submitButtonAction(textField)
        return true
    }
}
