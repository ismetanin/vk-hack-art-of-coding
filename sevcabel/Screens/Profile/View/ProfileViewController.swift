//
//  ProfileViewController.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

final class ProfileViewController: FeedBlockViewController {

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.setTableHeaderView(header: ProfileHeaderView.fromXib() ?? UIView())

        let items: [FeedItem] = [
            FeedItem(image: UIImage(named: "big_resale")!, title: "Big Resale Weekend", subtitle: "через 2 дня"),
            FeedItem(image: UIImage(named: "big_resale")!, title: "Праздник для корги", subtitle: "24 ноября"),
            FeedItem(image: UIImage(named: "big_resale")!, title: "Сольный концерт певицы Нины Карлссон", subtitle: "13 декабря"),
            FeedItem(image: UIImage(named: "big_resale")!, title: "One Love Fest", subtitle: "Со 2 по 3 января")
        ]
        self.configure(with: items)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.shouldUpdateHeaderViewFrame {
            // This is where table view's content (tableHeaderView, section headers, cells)
            // frames are updated to account for the new table header size.
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }

}
