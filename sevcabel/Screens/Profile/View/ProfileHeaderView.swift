//
//  ProfileHeaderView.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

final class ProfileHeaderView: UIView {

    // MARK: - IBOutlets

    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var mySevIdButton: UIButton!

    @IBOutlet private var dataSubviews: [UIView]!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - IBActions

    @IBAction func mySevIdButtonAction(_ sender: Any) {
        showSevIdAction?()
    }

    // MARK: - Properties

    var showSevIdAction: (() -> Void)?

    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        mySevIdButton.setTitleColor(.gray, for: .highlighted)
        mySevIdButton.setTitleColor(.gray, for: .focused)
        mySevIdButton.setTitleColor(.gray, for: .selected)

        activityIndicator.startAnimating()
        dataSubviews.forEach { $0.alpha = 0 }
    }

    func configure(with user: User) {
        nameLabel.text = user.firstname + " " + user.lastname
        photoImageView.loadImage(with: user.photoStringURL)
        UIView.animate(withDuration: 0.3) {
            self.dataSubviews.forEach { $0.alpha = 1 }
            self.activityIndicator.alpha = 0
        }
    }
    

}
