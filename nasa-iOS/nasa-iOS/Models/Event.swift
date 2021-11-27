//
//  Event.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/27.
//

import Foundation

struct EventData: Codable {
    let href: String
    let data: [Event]
}

struct EventCollection: Codable {
    let collection: EventDataCollection

}

struct EventDataCollection: Codable {
    let items: [EventData]
}

struct Event: Codable {
    let title: String
    let date_created: String
    let description: String
    let photographer: String?
}

struct EventLinks: Codable {
    let href: String

}
