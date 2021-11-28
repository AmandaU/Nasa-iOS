//
//  NasaApi.swift
//  nasa-iOS
//
//  Created by Amanda Baret on 2021/11/27.
//

import Foundation


import Foundation
import Combine

struct ApiService {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }

    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request) // 3
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data) // 4
                return Response(value: value, response: result.response) // 5
            }
            .receive(on: DispatchQueue.main) // 6
            .eraseToAnyPublisher() // 7
    }
}

enum NasaApi {
    static let apiService = ApiService()
}

extension NasaApi {

    static func getPhotos() -> AnyPublisher<CollectionDTO, Error> {
        var request = URLRequest(url:  URL(string: "https://images-api.nasa.gov/search?q=%22%22")!)
        let headers = [
            // "Authorization": "Bearer \(accessToken)",
            "Accept": "*/*",
            "Content-Type": "application/json"
        ]
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        return apiService.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

extension NasaApi {

    static func getImageUrl(url: String) -> AnyPublisher<[String], Error> {
        var request = URLRequest(url:  URL(string: url)!)
        let headers = [
            // "Authorization": "Bearer \(accessToken)",
            "Accept": "*/*",
            "Content-Type": "application/json"
        ]
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        return apiService.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
