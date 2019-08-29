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

    private static let highlightFactor: CGFloat = 0.96

    var icon: UIImage? {
        didSet { iconImageView.image = icon }
    }

    var guide: Guide? {
        didSet { guideDidSet() }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        selectionStyle = .none
        loadFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        loadFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        icon = nil
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        backgroundColoredView.layer.shadowOpacity = 0.3
        backgroundColoredView.layer.shadowColor = UIColor.gray.cgColor
        backgroundColoredView.layer.shadowOffset = .zero
        backgroundColoredView.layer.shadowRadius = 8
        backgroundColoredView.layer.cornerRadius = 8
    }

    private func guideDidSet() {
        titleLabel.text = guide?.name.uppercased()

        let endDate = GuideTableViewCell.formattedEndDate(guide)
        detailLable.text = endDate
        detailLable.isHidden = endDate == nil
        calendarIcon.isHidden = endDate == nil

        let location = GuideTableViewCell.formattedLocation(guide)
        locationLable.text = location
        locationLable.isHidden = location == nil
        locationIcon.isHidden = location == nil
    }

    private static func formattedLocation(_ guide: Guide?) -> String? {
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

    private static func formattedEndDate(_ guide: Guide?) -> String? {
        if let endDate = guide?.endDate {
            return "Ending on \(endDate)"
        } else {
            return nil
        }
    }
}

extension GuideTableViewCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        highlight(isSelected: false)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        highlight(isSelected: true)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        highlight(isSelected: true)
    }

    private func highlight(isSelected: Bool) {
        UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.5) { [weak self] in
            if isSelected {
                self?.transform = .identity
            } else {
                self?.transform = .init(scaleX: GuideTableViewCell.highlightFactor,
                                        y: GuideTableViewCell.highlightFactor)
            }
        }.startAnimation()
    }
}
