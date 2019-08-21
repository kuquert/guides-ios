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
    
    func load<T>(route: ApiRoute, completion: @escaping (T?, Error?) -> Void) where T : Decodable {
        var fileName: String {
            switch route {
            case .upcomingGuides:
                return  "upcomingGuides"
            default:
                return "404"
            }
        }
        
        guard let data = dataForFile(name: fileName) else {
            completion(nil, ApiError.noData)
            return
        }
        
        let decoder = JSONDecoder()
        let guidesResponse = try! decoder.decode(T.self, from: data)
        
        completion(guidesResponse, nil)
    }
    
    private func dataForFile(name: String) -> Data? {
        let path = Bundle.main.path(forResource: name, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        return data
    }
}
