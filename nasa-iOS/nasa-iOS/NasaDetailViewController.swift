//
//  NasaDetailViewController.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/28.
//

import UIKit

class NasaDetailViewController: UIViewController {

    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var imageLoader = ImageLoader()

    var photo: PhotographInfo?

    func configure(with photo: PhotographInfo) {
        self.photo = photo
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let photo = self.photo else {
            return
        }
        self.titleLabel.text = photo.title
        self.infoLabel.text = photo.info
        self.descriptionlabel.text = photo.description
        self.imageView.startShimmeringAnimation(direction: .leftToRight)
    }

    override func viewDidAppear(_ animated: Bool) {
        guard let url = self.photo?.imageSource else {
            return
        }
        NasaStore.instance.getImageUrl(url: url) { url, error in
            if !(error?.isEmpty ?? true) {
                self.imageView.stopShimmeringAnimation()
                self.showAlert(title: "No NASA image", message: "Unfortunatley we could not retireve the associated image. Please try later")
            } else{
                if let url = url {
                    self.imageLoader.obtainImageWithPath(imagePath: url) { (image) in
                        self.imageView.stopShimmeringAnimation()
                        self.imageView.image = image
                    }
                }
            }
        }

    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
}
