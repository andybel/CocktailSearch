//
//  MockSearchService.swift
//
//  Created by Andy Bell on 19.10.20.
//

import Foundation

class MockSearchService: SearchService {
    
    var emitRequestError: CSError?
    
    func fetchResults(for endpoint: CSEndpoint, completion: @escaping ((Result<[Drink], Error>) -> Void)) {
        
        guard emitRequestError == nil else {
            completion(.failure(emitRequestError!))
            return
        }
        
        do {
            
            let mockData = try StubDataTestHelper.loadMockJsonData(for: "cocktailsSearch")
            let mockResultWrapper = try JSONDecoder().decode(ResponseWrapper.self, from: mockData)
            let mockProducts = mockResultWrapper.drinks
            completion(.success(mockProducts))
            
        } catch {
            completion(.failure(error))
        }
    }
}
