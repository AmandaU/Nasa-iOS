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

    func getEvents(onDone: @escaping ([Event]?) ->Void) {
        cancellationToken = NasaApi.getEvents()
            .sink(
                receiveCompletion: ({ (completion) in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("\(error)")
                       onDone(nil)
                    }
                }),
            receiveValue: {

                let thing = $0
                
                onDone($0.collection.items[0].data)
            })
    }

}
