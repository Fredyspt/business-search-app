//
//  UIImageView+Extension.swift
//  BusinessSearch
//
//  Created by Fredy Sanchez on 03/02/23.
//

import UIKit
/*
 Having a global object as an image cache could not be the best idea.
 It is fast and gets the job done, but lacks persistance against URLCache,
 so a possible improvement could be to use URLCache instead
 */
let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    /*
     Load an image from an external URL and cache it if the request was successful.
     */
    func loadFrom(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print(error)
                return
            }
            if let data {
                DispatchQueue.main.async { [weak self] in
                    if let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: urlString as AnyObject)
                        self?.image = image
                    }
                }
            }
        }.resume()
    }
}
