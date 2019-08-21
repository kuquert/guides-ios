//
//  WebService.swift
//  guides
//
//  Created by Marcus Kuquert on 8/21/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import Foundation

struct WebService {
    static let shared = WebService()
    
    func loadGuides(completion: @escaping (GuidesResponse?, Error?) -> Void) {
        load(request: ApiRouter.upcomingGuides.request, completion: completion)
    }
    
    private func load<T:Decodable>(request: URLRequest, completion: @escaping (T?, Error?) -> Void) {
        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                
                guard let data = data else {
                    completion(nil, ApiError.noData)
                    return
                }
                
                let decoder = JSONDecoder()
                let guidesResponse = try! decoder.decode(T.self, from: data)
                
                completion(guidesResponse, error)
            }
        }.resume()
    }
}
