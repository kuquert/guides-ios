//
//  ViewController.swift
//  guides
//
//  Created by Marcus Kuquert on 8/21/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    private let cellId = "GuideTableViewCell"
    private var groupedGuides: [String: [Guide]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadUpcommingGuides()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GuideTableViewCell.self, forCellReuseIdentifier: cellId)
    }

    private func loadUpcommingGuides() {
        GuideFacade.shared.loadUpcomingGuides { [weak self] upcomingGuides, _ in
            guard let guides = upcomingGuides?.data else {
                return
            }
            self?.groupedGuides = ViewController.groupByDate(guides: guides)
            self?.tableView.reloadData()
        }
    }

    private static func groupByDate(guides: [Guide]) -> [String: [Guide]] {
        var dict: [String: [Guide]] = [:]
        guides.forEach {
            var temp = dict.removeValue(forKey: $0.startDate) ?? []
            temp.append($0)
            dict[$0.startDate] = temp
        }
        return dict
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return groupedGuides.keys.count
    }

    func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Starting on " + groupedGuides.keys.sorted()[section]
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keyForSection = groupedGuides.keys.sorted()[section]
        return groupedGuides[keyForSection]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let keyForSection = groupedGuides.keys.sorted()[indexPath.section]
        let guides = groupedGuides[keyForSection]

        guard let guide = guides?[indexPath.row] else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                                 for: indexPath) as! GuideTableViewCell
        cell.guide = guide
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
