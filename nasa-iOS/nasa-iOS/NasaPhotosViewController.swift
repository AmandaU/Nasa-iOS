//
//  NasaEventsViewController.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/27.
//

import Foundation
import UIKit
import Combine

class NasaPhotosViewController: UIViewController {
    static let photoCellIdentifier = "PhotoCell"
    static let showDetailSegueIdentifier = "toDetailSegue"
    
    @IBOutlet weak var nasaList: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var cancellables: Set<AnyCancellable> = []
    
    var dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "onImagesView"
        bindStore()
    }
    
    private func bindStore() {
        self.nasaList.dataSource = self.dataSource //
        NasaStore.instance.photosFetched.sink { [weak self] error in
            guard let self = self else {
                return
            }
            self.activityIndicator.stopAnimating()
            
            if let error = error {
                self.showAlert(title: "No NASA images", message: error)
                return
            }
           self.nasaList.reloadData()
        }.store(in: &cancellables)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // In case the photos were fetched in a previous scenario before this view was presented
        self.nasaList.reloadData()
        if !NasaStore.instance.photos.isEmpty {
            self.activityIndicator.stopAnimating()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showDetailSegueIdentifier,
           let destination = segue.destination as? NasaDetailViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = nasaList.indexPath(for: cell) {
            let photo = NasaStore.instance.photos[indexPath.row] 
            destination.configure(with: photo)
        }
    }
}
