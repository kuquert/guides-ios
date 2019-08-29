//
//  ApiRouter.swift
//  guides
//
//  Created by Marcus Kuquert on 8/21/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import Foundation

enum ApiRoute {
    case upcomingGuides
    case guide(String) // This is just an non-working example

    private func baseUrlWithPath(path: String) -> URL {
        return URL(string: "https://www.guidebook.com/service/v2/")!.appendingPathComponent(path)
    }

    private var method: HttpMethod {
        switch self {
        case .guide,
             .upcomingGuides:
            return .get
        }
    }

    private var url: URL {
        switch self {
        case .upcomingGuides:
            return baseUrlWithPath(path: "upcomingGuides")
        case let .guide(id):
            return baseUrlWithPath(path: "guides/\(id)")
        }
    }

    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
