//
//  UIImageView+loadFromUrl.swift
//
//  Created by Andy Bell on 11.10.20.
//

import UIKit

extension UIImageView {
    func loadImage(at url: URL, completion: (() -> Void)? = nil) {
        UIImageLoader.shared.load(url, for: self, completion: completion)
    }
    
    func cancelImageLoad() {
        UIImageLoader.shared.cancel(for: self)
    }
}
