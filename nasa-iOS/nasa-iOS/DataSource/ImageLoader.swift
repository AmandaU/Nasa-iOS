//
//  ImageLoader.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/28.
//

import SwiftUI

class ImageLoader {

    var cache: NSCache<NSString, UIImage>!

    init() {
        self.cache = NSCache()
    }

    func obtainImageWithPath(imagePath: String, completionHandler: @escaping (UIImage) -> ()) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {

            guard let url = URL(string: imagePath) else {
                let placeholder = UIImage(named: "placeholder") ?? UIImage()
                DispatchQueue.main.async {
                    completionHandler(placeholder)
                }
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                let img: UIImage! = UIImage(data: data)
                self.cache.setObject(img, forKey: imagePath as NSString)
                DispatchQueue.main.async {
                    completionHandler(img)
                }
            }
            task.resume()
        }
    }
}
