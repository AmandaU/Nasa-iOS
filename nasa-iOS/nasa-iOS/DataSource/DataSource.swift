//
//  EventsDataSource.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/27.
//

import UIKit

import Foundation
import UIKit

class DataSource: NSObject, UITableViewDataSource {

    var imageLoader = ImageLoader()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NasaStore.instance.photos.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NasaPhotosViewController.photoCellIdentifier, for: indexPath) as? PhotoCell else {
            fatalError("Unable to dequeue PhotoCell")
        }

        let photo = NasaStore.instance.photos[indexPath.row]
        imageLoader.obtainImageWithPath(imagePath: photo.thumb) { (image) in
            cell.endLoading()
            cell.photoImageView.image = image
        }
        cell.configure(photo: photo)
        return cell
    }
}

