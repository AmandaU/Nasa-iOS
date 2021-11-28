//
//  NasaStore.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/27.
//

import Foundation
import Combine
import UIKit

class NasaStore {

    var cancellationToken: AnyCancellable?

    static let instance = NasaStore()

    func getPhotos(onDone: @escaping ([PhotographInfo]?, String?) ->Void) {
        cancellationToken = NasaApi.getPhotos()
            .sink(
                receiveCompletion: ({ (completion) in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("\(error)")
                        onDone(nil, error.localizedDescription)
                    }
                }),
            receiveValue: {
                var photos = [PhotographInfo]()
                if let items = $0.collection.items {
                   items.forEach({ item in
                       if let imageSource = item.href,
                        let data = item.data?[0],
                          let links = item.links?[0] {
                           photos.append(PhotographInfo(imageSource: imageSource, data: data, link: links))
                       }
                   } )
                }
                onDone(photos.isEmpty ? nil : photos, photos.isEmpty ? "There are currenty no NASA images to display" : nil)
            })
    }

    func getImageUrl(url: String, onDone: @escaping (String?, String?) ->Void) {
        cancellationToken = NasaApi.getImageUrl(url: url)
            .sink(
                receiveCompletion: ({ (completion) in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("\(error)")
                        onDone(nil, error.localizedDescription)
                    }
                }),
            receiveValue: {

                onDone( ($0.isEmpty ?? true) ? "" : $0[0],  nil)
            })
    }

}
