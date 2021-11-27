//
//  NasaEventsViewController.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/27.
//

import Foundation
import UIKit


class NasaEventsViewController: UIViewController {
    static let eventCellIdentifier = "EventCell"
    @IBOutlet weak var nasaList: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let store = NasaStore()
    var dataSource = DataSource()

    override func viewDidLoad() {
             super.viewDidLoad()
        store.getEvents { events in
            self.activityIndicator.stopAnimating()
            guard let events = events else {
                return
            }
            self.dataSource.events = events // Pass data to DataSource class
            self.nasaList.dataSource = self.dataSource //
            self.nasaList.reloadData()
        }

         }

    static let showDetailSegueIdentifier = "ShowDetailSegue"

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == Self.showDetailSegueIdentifier,
//               let destination = segue.destination as? EventViewController,
//               let cell = sender as? UITableViewCell,
//               let indexPath = tableView.indexPath(for: cell) {
//                let reminder = self.events[indexPath.row]
//                destination.configure(with: reminder)
//            }
        }
}

