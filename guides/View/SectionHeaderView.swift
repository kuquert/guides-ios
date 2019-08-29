//
//  AlternativeSectionHeaderView.swift
//  guides
//
//  Created by Marcus Kuquert on 8/28/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView, NibLoadable {
    @IBOutlet var titleLabel: UILabel!

    var startDate: String? {
        didSet {
            titleLabel.text = "Starting on " + (startDate ?? "")
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        fromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
}
