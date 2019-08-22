//
//  GuideView.swift
//  guides
//
//  Created by Marcus Kuquert on 8/22/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import UIKit

final class GuideView: UIView, NibLoadable {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLable: UILabel!
    
    var guide: Guide? {
        didSet {
            titleLabel.text = guide?.name
            detailLable.text = "\(guide?.venue.city ?? ""), \(guide?.venue.state ?? "") · ends: \(guide?.endDate ?? "")"
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
