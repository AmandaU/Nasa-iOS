//
//  NasaStore.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/27.
//

import Foundation
import Combine
import UIKit

struct UrlModel {
    let url: String?
    let error: String?
}

class NasaStore: ObservableObject {

    @Published var photos = [PhotographInfo]()
    let photosFetched = PassthroughSubject<String?, Never>()
    let photoUrlFetched = PassthroughSubject<UrlModel, Never>()
    var cancellationToken: AnyCancellable?

    static let instance = NasaStore()

    init() {
        self.getPhotos()
    }

    private func getPhotos() {
        cancellationToken = NasaApi.getPhotos()
            .sink(
                receiveCompletion: ({ (completion) in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("\(error)")
                        self.photosFetched.send(error.localizedDescription)
                    }
                }),
            receiveValue: {
                self.photos = [PhotographInfo]()
                if let items = $0.collection.items {
                   items.forEach({ item in
                       if let imageSource = item.href,
                        let data = item.data?[0],
                          let links = item.links?[0] {
                           self.photos.append(PhotographInfo(imageSource: imageSource, data: data, link: links))
                       }
                   } )
                }
                self.photosFetched.send(self.photos.isEmpty ? "There are currenty no NASA images to display" : nil)
            })
    }

    func getImageUrl(url: String) {
        cancellationToken = NasaApi.getImageUrl(url: url)
            .sink(
                receiveCompletion: ({ (completion) in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("\(error)")
                        self.photoUrlFetched.send(UrlModel(url: nil, error: error.localizedDescription))

                    }
                }),
            receiveValue: {
                let url = $0.isEmpty ? nil : $0[0]
                let error = url == nil ? "We could not retrieve the image. Please try later" : nil
                self.photoUrlFetched.send(UrlModel(url: url, error: error))
            })
    }

}
