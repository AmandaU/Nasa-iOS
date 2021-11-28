//
//  NasaEventsViewController.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/27.
//

import Foundation
import UIKit


class NasaPhotosViewController: UIViewController {
    static let photoCellIdentifier = "PhotoCell"
    static let showDetailSegueIdentifier = "toDetailSegue"

    @IBOutlet weak var nasaList: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!


    var dataSource = DataSource()


    override func viewDidLoad() {
        super.viewDidLoad()
         NasaStore.instance.getPhotos { photos, error in
            self.activityIndicator.stopAnimating()
            if !(error?.isEmpty ?? true) {
                self.showAlert(title: "No NASA images", message:  "Unfortunately there is an issue fetching the NASA images. Please try later.")
                return
            }

            if !(error?.isEmpty ?? true)  {
                self.showAlert(title: "No NASA images", message:  "Unfortunately there are no NASA images currently. Please try later.")
                return
            }
            self.dataSource.photos = photos // Pass data to DataSource class
            self.nasaList.dataSource = self.dataSource //
            self.nasaList.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showDetailSegueIdentifier,
           let destination = segue.destination as? NasaDetailViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = nasaList.indexPath(for: cell) {
            if let photo = self.dataSource.photos?[indexPath.row] {
                destination.configure(with: photo)
            }
        }
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
}
