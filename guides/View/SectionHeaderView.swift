//
//  SectionHeaderView.swift
//  guides
//
//  Created by Marcus Kuquert on 8/25/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import UIKit

final class SectionHeaderView: UITableViewHeaderFooterView, NibLoadable {
    @IBOutlet var calendarView: UIView!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!

    var startDate: String? {
        didSet {
            // TODO: User guide object with parsed date
            let components = startDate?.components(separatedBy: " ") ?? []
            monthLabel.text = components[0].uppercased()
            dayLabel.text = components[1].replacingOccurrences(of: ",", with: "")
            yearLabel.text = components[2]
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundView = UIView()
        backgroundView!.backgroundColor = .clear
        fromNib()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        calendarView.layer.shadowOpacity = 0.7
        calendarView.layer.shadowColor = UIColor.gray.cgColor
        calendarView.layer.shadowOffset = .zero
        calendarView.layer.shadowRadius = 8
        calendarView.layer.cornerRadius = 6
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
}
