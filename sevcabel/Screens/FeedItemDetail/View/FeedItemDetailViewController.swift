//
//  FeedItemDetailViewController.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

final class FeedItemDetailViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var cardImitateView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!

    // MARK: - IBActions

    @IBAction private func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - NSLayoutConstraints

    @IBOutlet private weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var scrollViewTopConstraints: NSLayoutConstraint!

    // MARK: - UIViewController

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsets(top: imageView.frame.height - 10,
                                               left: 0,
                                               bottom: 0,
                                               right: 0)
        imageViewTopConstraint.constant = -UIApplication.shared.statusBarFrame.height
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutCardView()
    }

    // MARK: - Internal helpers

    func configure(with feedItem: FeedItem) {
        
    }

    // MARK: - Private methods

    private func layoutCardView() {
        cardImitateView.round(corners: [.topRight, .topLeft], radius: 20)
        cardView.round(corners: [.topRight, .topLeft], radius: 20)
    }

}
