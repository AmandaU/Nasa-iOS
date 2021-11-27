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
    static let eventCellIdentifier = "EventCell"
    var events: [Event]? = nil

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events?.count ?? 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NasaEventsViewController.eventCellIdentifier, for: indexPath) as? EventCell else {
            fatalError("Unable to dequeue EventCell")
        }
        if let event = events?[indexPath.row] {
            cell.configure(name: event.title ?? "", date: event.date_created ?? "", description: event.description ?? "", imageUrl: event.description ?? "")
            // tableView.reloadRows(at: [indexPath], with: .none)
            return cell
        } else {
            return  UITableViewCell()
        }
    }
}

