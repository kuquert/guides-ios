//
//  Guide.swift
//  guides
//
//  Created by Marcus Kuquert on 8/21/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import Foundation

struct Guide: Codable {
    var startDate: String
    var endDate: String
    var name: String
    var url: String
    var venue: Venue
    var objType: String
    var icon: String
}
