//
//  EventCell.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/27.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet var eventImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    // var imageUrl: String = ""

   func configure(name: String, date: String, description: String, imageUrl: String) {
           nameLabel.text = name
        descriptionLabel.text = "\(description)-\(date)"
       // imageUrl = imageUrl
       }
}
