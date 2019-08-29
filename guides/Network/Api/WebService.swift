//
//  WebService.swift
//  guides
//
//  Created by Marcus Kuquert on 8/21/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import Foundation

struct WebService: Service {
    static let shared = WebService()

    func load<T>(route: ApiRoute, completion: @escaping (T?, Error?) -> Void) where T: Decodable {
        URLSession.shared.dataTask(with: route.request) { data, _, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, error)
                    return
                }

                guard let data = data else {
                    completion(nil, ApiError.noData)
                    return
                }

                guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(nil, ApiError.decoderFailed)
                    return
                }

                completion(decodedResponse, nil)
            }
        }.resume()
    }
}
