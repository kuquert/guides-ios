//
//  GuideTableViewCell.swift
//  guides
//
//  Created by Marcus Kuquert on 8/22/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import UIKit

final class GuideTableViewCell: UITableViewCell, NibLoadable {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLable: UILabel!
    @IBOutlet var calendarIcon: UIImageView!
    @IBOutlet var locationLable: UILabel!
    @IBOutlet var locationIcon: UIImageView!
    @IBOutlet var backgroundColoredView: UIView!

    var guide: Guide? {
        didSet {
            titleLabel.text = guide?.name.uppercased()
            
            let endDate = formattedEndDate(guide)
            detailLable.text = endDate
            detailLable.isHidden = endDate == nil
            calendarIcon.isHidden = endDate == nil

            let location = formattedLocation(guide)
            locationLable.text = location
            locationLable.isHidden = location == nil
            locationIcon.isHidden = location == nil
        }
    }

    func setIcon(_ icon: UIImage) {
        iconImageView.image = icon
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        fromNib()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        backgroundColoredView.layer.shadowOpacity = 0.3
        backgroundColoredView.layer.shadowColor = UIColor.gray.cgColor
        backgroundColoredView.layer.shadowOffset = .zero
        backgroundColoredView.layer.shadowRadius = 8
        backgroundColoredView.layer.cornerRadius = 8
    }

    private func formattedLocation(_ guide: Guide?) -> String? {
        if let city = guide?.venue.city, let state = guide?.venue.state {
            return "\(city), \(state)"
        } else if let city = guide?.venue.city {
            return "\(city)"
        } else if let state = guide?.venue.state {
            return "\(state)"
        } else {
            return nil
        }
    }

    private func formattedEndDate(_ guide: Guide?) -> String? {
        if let endDate = guide?.endDate {
            return "Ending on \(endDate)"
        } else {
            return nil
        }
    }
}
