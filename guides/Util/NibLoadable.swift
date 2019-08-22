//
//  NibLoadable.swift
//  guides
//
//  Created by Marcus Kuquert on 8/22/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import UIKit

protocol NibLoadable where Self: UIView {
    func fromNib() -> UIView?
}

extension NibLoadable {
    @discardableResult
    func fromNib() -> UIView? {
        let contentView = Bundle(for: type(of: self))
            .loadNibNamed(String(describing: type(of: self)),
                          owner: self,
                          options: nil)?
            .first as! UIView
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.clipEdges(to: self)
        return contentView
    }
}
