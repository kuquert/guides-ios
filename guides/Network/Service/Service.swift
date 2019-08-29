//
//  Service.swift
//  guides
//
//  Created by Marcus Kuquert on 8/21/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import Foundation

protocol Service {
    func load<T: Decodable>(route: ApiRoute, completion: @escaping (T?, Error?) -> Void)
}
