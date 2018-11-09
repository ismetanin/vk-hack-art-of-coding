//
//  UITableView.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

public extension UITableView {

    public func registerNib(_ cellType: UITableViewCell.Type) {
        self.register(UINib(nibName: cellType.nameOfClass, bundle: nil),
                      forCellReuseIdentifier: cellType.nameOfClass)
    }

}
