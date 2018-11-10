//
//  FeedBlockViewController.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

class FeedBlockViewController: UIViewController {

    // MARK: - Properties

    var tableView: UITableView = UITableView()
    private var items: [FeedItem] = []
    private lazy var adapter = FeedTableViewAdapter(tableView: tableView)

    // MARK: - UIViewController

    override func loadView() {
        super.loadView()
        view.addSubview(tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    // MARK: - Internal methods

    func configure(with items: [FeedItem]) {
        self.items = items
        adapter.configure(with: items)
    }

    // MARK: - Private methods

    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 247
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}
