//
//  ViewController.swift
//  guides
//
//  Created by Marcus Kuquert on 8/21/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGuides()
    }

    private func loadGuides() {
        let url = URL(string: "https://www.guidebook.com/service/v2/upcomingGuides/")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                print(error ?? "Empty error")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        }.resume()
    }
}

