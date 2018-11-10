//
//  ProfileViewController.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit
import SwiftyVK

final class ProfileViewController: FeedBlockViewController {

    // MARK: - Properties

    private lazy var transition = DrawerCustomTransitionDelegate()
    private lazy var header: ProfileHeaderView = ProfileHeaderView.fromXib() ?? ProfileHeaderView()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserInfo()
        tableView.setTableHeaderView(header: header)
        header.showSevIdAction = {
            let controller = IdentifierViewController.fromStoryboard()
            controller.modalPresentationStyle = .overFullScreen
            controller.transitioningDelegate = self.transition
            self.present(controller, animated: true, completion: nil)
        }
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

    // MARK: - Private methods

    private func loadUserInfo() {
        VK.API.Users.get([.fields: "photo_200"])
            .onSuccess { [weak self] info in
                let decoder = JSONDecoder()
                guard let user = try decoder.decode(Array<User>.self, from: info).first else {
                    return
                }
                self?.configure(with: user)
            }
            .onError { error in
                print(error)
            }
            .send()
    }

    private func configure(with user: User) {
        DispatchQueue.main.async {
            self.header.configure(with: user)
            self.fillTableWithItems()
        }
    }

    private func fillTableWithItems() {
        let items: [FeedItem] = [
            FeedItem(image: UIImage(named: "big_resale")!, title: "Big Resale Weekend", subtitle: "через 2 дня"),
            FeedItem(image: UIImage(named: "big_resale")!, title: "Праздник для корги", subtitle: "24 ноября"),
            FeedItem(image: UIImage(named: "big_resale")!, title: "Сольный концерт певицы Нины Карлссон", subtitle: "13 декабря"),
            FeedItem(image: UIImage(named: "big_resale")!, title: "One Love Fest", subtitle: "Со 2 по 3 января")
        ]
        self.configure(with: items)
    }

}
