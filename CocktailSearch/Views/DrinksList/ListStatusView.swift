//
//  ListStatusView.swift
//  CocktailSearch
//
//  Created by Andy Bell on 18.10.20.
//

import UIKit

enum ListStatus: Equatable {
    case awaitingInput
    case loadingData
    case noItemsReturned
    case noNetwork
    case error(CSError)
    
    var description: String {
        switch self {
        case .awaitingInput:
            return NSLocalizedString("use_the_input_field_above_to_search_for_drinks", comment: "ListStatus.awaitingInput description")
        case .loadingData:
            return NSLocalizedString("searching", comment: "ListStatus.loadingData description") + "..."
        case .noItemsReturned:
            return NSLocalizedString("no_results_were_returned_for_this_item", comment: "ListStatus.noItemsReturned description")
        case .noNetwork:
            return NSLocalizedString("please_check_your_connection", comment: "ListStatus.noNetwork description")
        case .error(let error):
            return error.localizedDescription
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .awaitingInput:
            return UIImage(systemName: "magnifyingglass.circle")
        case .loadingData:
            return nil
        case .noItemsReturned:
            return UIImage(systemName: "battery.0")
        case .noNetwork:
            return UIImage(systemName: "wifi.slash")
        case .error:
            return UIImage(systemName: "exclamationmark.octagon")
        }
    }
}

final class ListStatusView: UIView {

    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    func configure(with listStatus: ListStatus) {
        
        mainLabel.accessibilityIdentifier = "current_status_label"
        mainLabel.text = listStatus.description
        iconImageView.image = listStatus.icon
        
        let isLoadingState = listStatus == .loadingData
        iconImageView.isHidden = isLoadingState
        if isLoadingState {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
    
    func configure(with error: Error) {
        
        guard let tcError = error as? CSError else {
            configure(with: .error(.general("An error occurred")))
            return
        }
            
        switch tcError {
        case .requestReturnedEmpty:
            configure(with: .noItemsReturned)
        case .noNetwork:
            configure(with: .noNetwork)
        case .emptyInput:
            configure(with: .error(tcError))
        default:
            configure(with: .error(.general("An error occurred")))
        }
    }
}
