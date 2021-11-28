//
//  EventCell.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/27.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    func configure(photo: PhotographInfo) {
        nameLabel.text = photo.title
        descriptionLabel.text = photo.info
        photoImageView.startShimmeringAnimation(direction: .leftToRight)
       }

    func endLoading() {
        photoImageView.stopShimmeringAnimation()
    }
}
