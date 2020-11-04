//
//  ImageLoader.swift
//
//  Created by Andy Bell on 13.10.20.
//

import UIKit

final class ImageLoader {
    
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()

    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
        
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            defer { self.runningRequests.removeValue(forKey: uuid) }
            
            if let err = error, (err as NSError).code != NSURLErrorCancelled {
                completion(.failure(err))
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[url] = image
                completion(.success(image))
                return
            }
        }
        task.resume()
        
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}
