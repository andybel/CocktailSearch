//
//  CSError.swift
//  CocktailSearch
//
//  Created by Andy Bell on 04.11.20.
//

import Foundation

enum CSError: Error, Equatable {
    case decodingError
    case noData
    case requestReturnedEmpty
    case noNetwork
    case emptyInput
    case requestConstructionError
    case general(String)
}

extension CSError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .decodingError:
            return NSLocalizedString("error_decoding_data_from_the_server", comment: "CSError.decodingError description")
        case .noData:
            return NSLocalizedString("error_retrieving_data_from_the_server", comment: "noData.decodingError description")
        case .requestReturnedEmpty:
            return NSLocalizedString("no_items_found", comment: "CSError.requestReturnedEmpty description")
        case .noNetwork:
            return NSLocalizedString("no_network_connection", comment: "CSError.noNetwork description")
        case .emptyInput:
            return NSLocalizedString("search_is_empty", comment: "CSError.emptyInput description")
        case .requestConstructionError:
            return NSLocalizedString("error_constructing_the_request", comment: "CSError.requestConstructionError description")
        case .general(let desc):
            return desc
        }
    }
}
