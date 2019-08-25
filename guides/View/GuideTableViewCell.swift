//
//  GuideTableViewCell.swift
//  guides
//
//  Created by Marcus Kuquert on 8/22/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import UIKit

@IBDesignable
class GuideTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLable: UILabel!
    @IBOutlet weak var locationLable: UILabel!

    var guide: Guide? {
        didSet {
            titleLabel.text = guide?.name
            detailLable.text = endDateFormatter(guide)
            locationLable.text = venueFormatter(guide)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        fromNib()
    }

    private func venueFormatter(_ guide: Guide?) -> String {
        if let city = guide?.venue.city, let state = guide?.venue.state {
            return "\(city), \(state)"
        } else if let city = guide?.venue.city {
            return "\(city)"
        } else if let state = guide?.venue.state {
            return "\(state)"
        } else {
            return  ""
        }
    }

    private func endDateFormatter(_ guide: Guide?) -> String {
        if let endDate = guide?.endDate {
            return "Ending on \(endDate)"
        } else {
            return ""
        }
    }
}
