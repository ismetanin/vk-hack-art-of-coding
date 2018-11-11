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

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var cardImitateView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var goButton: UIButton!

    // MARK: - IBActions

    @IBAction private func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func goAction(_ sender: Any) {
        if goButton.titleLabel?.text == "Я пойду" {

        } else {
            let controller = IdentifierViewController.fromStoryboard() as! IdentifierViewController
            controller.configureForTicket()
            controller.modalPresentationStyle = .overFullScreen
            controller.transitioningDelegate = self.transition
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    // MARK: - NSLayoutConstraints

    @IBOutlet private weak var descriptionToGoButton: NSLayoutConstraint!
    @IBOutlet private weak var descriptionToBottom: NSLayoutConstraint!
    @IBOutlet private weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var scrollViewTopConstraints: NSLayoutConstraint!

    // MARK: - Properties

    private var item: FeedItem!
    private lazy var transition = DrawerCustomTransitionDelegate()

    // MARK: - UIViewController

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsets(top: imageView.frame.height - 20,
                                               left: 0,
                                               bottom: 0,
                                               right: 0)
        imageViewTopConstraint.constant = -UIApplication.shared.statusBarFrame.height

        imageView.image = item.fullImage
        subtitleLabel.text = item.subtitle
        titleLabel.text = item.title
        descriptionLabel.attributedText = item.description.string(with: [StringAttribute.lineHeight(7)])

        if item.isEvent {
            descriptionToGoButton.priority = .defaultHigh
            descriptionToBottom.priority = .defaultLow
            goButton.isHidden = false
        } else {
            descriptionToGoButton.priority = .defaultLow
            descriptionToBottom.priority = .defaultHigh
            goButton.isHidden = true
        }

        if item.isRegistered {
            goButton.setTitle("Мой билет", for: .normal)
        } else {
            goButton.setTitle("Я пойду", for: .normal)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutCardView()
    }

    // MARK: - Internal helpers

    func configure(with feedItem: FeedItem) {
        self.item = feedItem
    }

    // MARK: - Private methods

    private func layoutCardView() {
        cardImitateView.round(corners: [.topRight, .topLeft], radius: 20)
        cardView.round(corners: [.topRight, .topLeft], radius: 20)
    }

}
