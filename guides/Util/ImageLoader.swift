//
//  ImageLoader.swift
//  guides
//
//  Created by Marcus Kuquert on 8/28/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import UIKit

struct ImageLoader {
    static let shared = ImageLoader()
    let cache = NSCache<NSString, UIImage>()
    let placeholder = UIImage(named: "placeholder")!

    func obtainImageWithPath(imagePath: String, completionHandler: @escaping (UIImage) -> Void) {
        if let image = cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
            return
        }
        DispatchQueue.main.async {
            completionHandler(self.placeholder)
        }
        URLSession.shared.downloadTask(with: URL(string: imagePath)!) { location, _, _ in
            guard let location = location else {
                return
            }
            guard let data = try? Data(contentsOf: location) else {
                return
            }
            guard let image = UIImage(data: data) else {
                return
            }
            self.cache.setObject(image, forKey: imagePath as NSString)
            DispatchQueue.main.async {
                completionHandler(image)
            }
        }.resume()
    }
}
