//
//  GuideView.swift
//  guides
//
//  Created by Marcus Kuquert on 8/22/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import UIKit

final class GuideView: UIView, NibLoadable {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var guide: Guide? {
        didSet {
            nameLabel.text = guide?.name
            cityLabel.text = guide?.venue.city
            stateLabel.text = guide?.venue.state
            dateLabel.text = guide?.endDate
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }
}
