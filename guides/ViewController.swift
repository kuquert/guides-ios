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
        GuideFacade.shared.loadUpcomingGuides { (upcomingGuides: UpcomingGuidesResponse?, error: Error?) in
            self.guides = upcomingGuides?.data
            self.tableView.reloadData()
        }
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
