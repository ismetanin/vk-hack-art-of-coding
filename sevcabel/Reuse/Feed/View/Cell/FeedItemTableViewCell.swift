//
//  FeedItemTableViewCell.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

final class FeedItemTableViewCell: UITableViewCell {

    static var identifier: String = String(describing: FeedItemTableViewCell.self)

    // MARK: - IBOutlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var feedItemImageView: UIImageView!

    // MARK: - Internal methods

    func configure(with feedItem: FeedItem) {
        titleLabel.text = feedItem.title
        subtitleLabel.text = feedItem.title
        feedItemImageView.image = feedItem.image
    }
    
}
