//
//  ViewController.swift
//  guides
//
//  Created by Marcus Kuquert on 8/21/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var guides: [Guide]?
    
    @IBOutlet weak var tableView: UITableView!
    
    private func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        loadGuides()
    }

    private func loadGuides() {
        let url = URL(string: "https://www.guidebook.com/service/v2/upcomingGuides/")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            let decoder = JSONDecoder()
            let guidesResponse = try! decoder.decode(GuidesResponse.self, from: data)
            let guides = guidesResponse.data
            print(guides)
            DispatchQueue.main.async {
                self?.guides = guides
                self?.tableView.reloadData()
            }
        }.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guides?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let guide = guides?[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "guideTableViewCell")
        cell.textLabel?.text = guide.name
        cell.detailTextLabel?.text = guide.url
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
