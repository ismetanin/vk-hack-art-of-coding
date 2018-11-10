//
//  FeedTableViewAdapter.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

final class FeedTableViewAdapter: NSObject {

    // MARK: - Properties

    fileprivate var items: [FeedItem] = []
    fileprivate (set) var tableView: UITableView

    var didSelectItem: ((FeedItem) -> Void)?

    // MARK: - Initialization and deinitialization

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(
            UINib(nibName: FeedItemTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: FeedItemTableViewCell.identifier
        )
    }

    // MARK: - Internal methods

    func configure(with items: [FeedItem]) {
        self.items = items
        self.tableView.reloadData()
    }

}


// MARK: - UITableViewDataSource

extension FeedTableViewAdapter: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedItemTableViewCell.identifier,
                                                 for: indexPath) as? FeedItemTableViewCell
        cell?.configure(with: items[indexPath.row])
        return cell ?? UITableViewCell()
    }

}

// MARK: - UITableViewDelegate

extension FeedTableViewAdapter: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectItem?(items[indexPath.row])
    }

}
