//
//  ViewController.swift
//  guides
//
//  Created by Marcus Kuquert on 8/21/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    private var groupedGuides: [String: [Guide]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Upcomming Guides"
        setupTableView()
        loadUpcommingGuides()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(GuideTableViewCell.self,
                           forCellReuseIdentifier: GuideTableViewCell.reuseIdentifier())
        
        tableView.estimatedSectionHeaderHeight = 60
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.register(SectionHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: SectionHeaderView.reuseIdentifier())
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
        return
            guides.reduce(into: [String: [Guide]]()) { dict, guide in
                var temp = dict.removeValue(forKey: guide.startDate) ?? []
                temp.append(guide)
                dict[guide.startDate] = temp
            }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return groupedGuides.keys.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.reuseIdentifier()) as! SectionHeaderView
        header.startDate = groupedGuides.keys.sorted()[section]
        return header
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

        let cell = tableView.dequeueReusableCell(withIdentifier: GuideTableViewCell.reuseIdentifier(),
                                                 for: indexPath) as! GuideTableViewCell

        cell.guide = guide

        ImageLoader.shared.obtainImageWithPath(imagePath: guide.icon) { image in
            if let updateCell = tableView.cellForRow(at: indexPath) as? GuideTableViewCell {
                updateCell.icon = image
            }
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
