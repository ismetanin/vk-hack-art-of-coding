//
//  UITableView.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

extension UITableView {

    var shouldUpdateHeaderViewFrame: Bool {
        guard let headerView = self.tableHeaderView else { return false }
        let oldSize = headerView.bounds.size
        // Update the size
        headerView.layoutIfNeeded()
        let newSize = headerView.bounds.size
        return oldSize != newSize
    }

    func registerNib(_ cellType: UITableViewCell.Type) {
        self.register(UINib(nibName: cellType.nameOfClass, bundle: nil),
                      forCellReuseIdentifier: cellType.nameOfClass)
    }

    // Sets the tableHeaderView so that the required height can be determined,
    // update the header's frame and set it again
    func setTableHeaderView(header: UIView) {
        header.translatesAutoresizingMaskIntoConstraints = false

        self.tableHeaderView = header

        // ** Must setup AutoLayout after set tableHeaderView.
        header.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        header.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        header.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }

}
