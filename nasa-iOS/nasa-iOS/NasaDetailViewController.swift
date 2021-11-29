//
//  NasaDetailViewController.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/28.
//

import UIKit
import Combine

class NasaDetailViewController: UIViewController {

    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var imageLoader = ImageLoader()
    private var cancellables: Set<AnyCancellable> = []

    var photo: PhotographInfo?

    func configure(with photo: PhotographInfo) {
        self.photo = photo
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindStore()
    }

    private func bindStore() {

        NasaStore.instance.photoUrlFetched.sink { [weak self] urlModel in
            guard let self = self else {
                return
            }

            if let error = urlModel.error {
                self.imageView.stopShimmeringAnimation()
                self.showAlert(title: "No NASA image", message: error)
                return
            }

            if let url = urlModel.url {
                self.imageLoader.obtainImageWithPath(imagePath: url) { (image) in
                    self.imageView.stopShimmeringAnimation()
                    self.imageView.image = image
                }
            }
        }.store(in: &cancellables)
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let photo = self.photo else {
            return
        }
        self.titleLabel.text = photo.title
        self.infoLabel.text = photo.info
        self.descriptionlabel.text = photo.description
        self.imageView.startShimmeringAnimation(direction: .leftToRight)
        NasaStore.instance.getImageUrl(url: photo.imageSource)
    }
}
