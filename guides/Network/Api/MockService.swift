//
//  MockService.swift
//  guides
//
//  Created by Marcus Kuquert on 8/21/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import Foundation

struct MockService: Service {
    static let shared = MockService()

    func load<T>(route: ApiRoute, completion: @escaping (T?, Error?) -> Void) where T: Decodable {
        guard let path = route.mockFilePath else {
            completion(nil, ApiError.invalidMockFilePath)
            return
        }

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) else {
            completion(nil, ApiError.mockFileNotFound)
            return
        }

        guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
            completion(nil, ApiError.decoderFailed)
            return
        }

        completion(decodedResponse, nil)
    }
}
