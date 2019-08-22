//
//  ViewController.swift
//  guides
//
//  Created by Marcus Kuquert on 8/21/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var groupedGuides: [String : [Guide]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        GuideFacade.shared.loadUpcomingGuides { [weak self] (upcomingGuides, error) in
            guard let guides = upcomingGuides?.data else {
                return
            }
            self?.groupedGuides = ViewController.groupByDate(guides: guides)
            self?.tableView.reloadData()
        }
    }
    
    private func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private static func groupByDate(guides: [Guide]) -> [String : [Guide]] {
        var dict: [String : [Guide]] = [:]
        guides.forEach {
            var temp = dict.removeValue(forKey: $0.startDate) ?? []
            temp.append($0)
            dict[$0.startDate] = temp
        }
        return dict
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedGuides.keys.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupedGuides.keys.sorted()[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keyForSection = groupedGuides.keys.sorted()[section]
        return groupedGuides[keyForSection]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let keyForSection = groupedGuides.keys.sorted()[indexPath.section]
        let guides_ = groupedGuides[keyForSection]
        
        guard let guide = guides_?[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "guideTableViewCell")
        cell.textLabel?.text = guide.name
        cell.detailTextLabel?.text = guide.startDate
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
