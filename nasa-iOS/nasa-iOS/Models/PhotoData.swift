//
//  Event.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/27.
//

import Foundation

struct DataDTO: Codable {
    let href: String?
    let data: [ItemDTO]?
    let links: [LinkDTO]?
}

struct LinkDTO: Codable {
    let href: String?
}

struct CollectionDTO: Codable {
    let collection: DataCollectionDTO
}

struct DataCollectionDTO: Codable {
    let items: [DataDTO]?
}

struct ItemDTO: Codable {
    let title: String?
    let date_created: String?
    let description: String?
    let photographer: String?
    let secondary_creator: String?
}

struct PhotographInfo {
    let title: String
    let dateCreated: Date
    let description: String
    let photographer: String
    let secondaryCreator: String
    let thumb: String
    let imageSource: String

    init(imageSource: String, data: ItemDTO, link: LinkDTO) {
        self.title = data.title ?? ""

        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: data.date_created ?? "") {
            self.dateCreated = date
        } else {
            self.dateCreated = Date()
        }
       // self.dateCreated = dateFormatter.date(from: data.date_created ?? "") ?? Date()
        self.description = data.description ?? ""
        self.photographer = data.photographer ?? ""
        self.secondaryCreator = data.secondary_creator ?? ""
        self.thumb = link.href ?? ""
        self.imageSource = imageSource
        }

    var dateFormmater: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        return dateFormatter
    }

    var info: String {
        let author = self.photographer.isEmpty ? self.secondaryCreator.isEmpty ? "No author info available" : self.secondaryCreator : self.photographer
        let description = "\(author) | "
        let date = dateFormmater.string(from: self.dateCreated)
       return "\(description)-\(date)"
    }
    }
