//
//  UIImageView+Extension.swift
//  BusinessSearch
//
//  Created by Fredy Sanchez on 03/02/23.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func loadFrom(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let safeData = data {
                DispatchQueue.main.async { [weak self] in
                    if let image = UIImage(data: safeData) {
                        imageCache.setObject(image, forKey: urlString as AnyObject)
                        self?.image = image
                    }
                }
            }
        }.resume()
    }
}
