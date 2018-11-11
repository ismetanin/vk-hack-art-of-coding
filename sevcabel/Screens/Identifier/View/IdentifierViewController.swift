//
//  IdentifierViewController.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 11/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

final class IdentifierViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    // MARK: - Properties

    private var titleText: String = "Покажи свой СевID сотруднику Севкабеля"
    private var descriptionText: NSAttributedString = "Твой персональный СевID даст возможность получать скидки на всей территории Порта!".string(with: [StringAttribute.lineHeight(5), StringAttribute.aligment(.center)])

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGr = UITapGestureRecognizer(target: self, action: #selector(contentTap))
        view.addGestureRecognizer(tapGr)

        titleLabel.text = titleText
        descriptionLabel.attributedText = descriptionText
    }

    // MARK: - Internal methods

    func configureForTicket() {
        titleText = "Покажи свой СевID на входе"
        descriptionText = "Твой персональный СевID будет твоим билетом на мероприятие!".string(with: [StringAttribute.lineHeight(5)])
    }

    func configureForQR() {
        titleText = "Покажи свой СевID сотруднику Севкабеля"
        descriptionText = "Твой персональный СевID даст возможность получать скидки на всей территории Порта!".string(with: [StringAttribute.lineHeight(5)])
    }

    // MARK: - Private methods

    @objc
    private func contentTap() {
        dismiss(animated: true, completion: nil)
    }

}
