//
//  GuideFacade.swift
//  guides
//
//  Created by Marcus Kuquert on 8/21/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import Foundation

struct GuideFacade {
    private let service: Service
    
    static let shared = GuideFacade(service: WebService.shared)
    static let sharedLocal = GuideFacade(service: MockService.shared)

    func loadUpcomingGuides(completion: @escaping (UpcomingGuidesResponse?, Error?) -> Void) {
        service.load(route: ApiRoute.upcomingGuides, completion: completion)
    }
}
