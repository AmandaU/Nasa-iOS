//
//  ImageLoader.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/28.
//

import SwiftUI

class ImageLoader {

//    var task: URLSessionDownloadTask!
//    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!

    init() {
      //  session = URLSession.shared
      //  task = URLSessionDownloadTask()
        self.cache = NSCache()
    }

    func obtainImageWithPath(imagePath: String, completionHandler: @escaping (UIImage) -> ()) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
//            let placeholder = #imageLiteral(resourceName: "placeholder")
//            DispatchQueue.main.async {
//                completionHandler(placeholder)
//            }
            let url: URL! = URL(string: imagePath)
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
