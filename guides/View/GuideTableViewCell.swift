//
//  GuideTableViewCell.swift
//  guides
//
//  Created by Marcus Kuquert on 8/22/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import UIKit

class GuideTableViewCell: UITableViewCell {
    
    @IBOutlet var guideView: GuideView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func render(guide: Guide) {
        guideView.guide = guide
    }
}
