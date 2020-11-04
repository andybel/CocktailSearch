//
//  SearchService.swift
//  ThaliaChallenge
//
//  Created by Andy Bell on 17.10.20.
//

import Foundation

protocol SearchService {
    func fetchResults(for endpoint: CSEndpoint, completion: @escaping ((_ :Result<[Drink], Error>) -> Void))
}

final class SearchServiceDefault: SearchService {
    
    private var requestTask: URLSessionDataTask?
    
    func fetchResults(for endpoint: CSEndpoint, completion: @escaping ((_ :Result<[Drink], Error>) -> Void)) {
        
        if let currentTask = requestTask {
            currentTask.cancel()
        }
        
        guard let url = endpoint.url else {
            completion(.failure(CSError.requestConstructionError))
            return
        }
        
        print("Request with url: \(url.absoluteString)")

        requestTask = URLSession.shared.dataTask(with: url) { (data, resp, error) in

            guard error == nil else {
                completion(.failure(error!))
                return
            }

            guard let data = data else {
                completion(.failure(CSError.noData))
                return
            }

            // For Debug only...
            data.printAsString()

            do {
                let resultWrapper = try JSONDecoder().decode(ResponseWrapper.self, from: data)
                completion(.success(resultWrapper.drinks))
            } catch {
                completion(.failure(error))
            }
        }
        requestTask?.resume()
    }
}
