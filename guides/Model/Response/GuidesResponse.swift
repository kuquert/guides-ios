//
//  GuidesResponse.swift
//  guides
//
//  Created by Marcus Kuquert on 8/21/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import Foundation

struct GuidesResponse: Codable {
    var total: String
    var data: [Guide]
}
