//
//  GuideFacade.swift
//  guides
//
//  Created by Marcus Kuquert on 8/21/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import Foundation

struct GuideFacade {
    
    static let shared = GuideFacade()
    private let service: Service = WebService.shared
    
    func loadUpcomingGuides(completion: @escaping (UpcomingGuidesResponse?, Error?) -> Void) {
        service.load(route: ApiRouter.upcomingGuides, completion: completion)
    }
}
