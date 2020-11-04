//
//  UIImageLoader.swift
//
//  Created by Andy Bell on 13.10.20.
//

import UIKit

final class UIImageLoader {
    
    static let shared = UIImageLoader()
    
    private let imageLoader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]()
    
    private init() { }
    
    func load(_ url: URL, for imageView: UIImageView, completion: (() -> Void)? = nil) {
     
        let token = imageLoader.loadImage(url) { result in
            
            defer { self.uuidMap.removeValue(forKey: imageView) }
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                    completion?()
                }
            } catch {
                print("loadImage error (will fail silent): \(error)")
            }
        }
        
        if let token = token {
            uuidMap[imageView] = token
        }
    }
    
    func cancel(for imageView: UIImageView) {
        guard let uuid = uuidMap[imageView] else {
            return
        }
        imageLoader.cancelLoad(uuid)
        uuidMap.removeValue(forKey: imageView)
    }
}
