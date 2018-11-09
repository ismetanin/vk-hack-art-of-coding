//
//  FeedViewController.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 09/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var pageContainer: UIView!
    @IBOutlet weak var switchContainer: UIView!

    // MARK: - Properties

    private lazy var switchControl = Switch()
    private var pager: Pager!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSwitchControl()
        configurePageController()
    }

    // MARK: - Internal helpers

    // MARK: - Private methods

    private func configurePageController() {
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .red
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .blue

        let pager = Pager(container: pageContainer,
                          parent: self,
                          segments: [vc1, vc2])
        self.pager = pager
    }

    private func configureSwitchControl() {
        switchContainer.addSubview(switchControl)

        switchControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            switchControl.topAnchor.constraint(equalTo: switchContainer.safeAreaLayoutGuide.topAnchor),
            switchControl.bottomAnchor.constraint(equalTo: switchContainer.safeAreaLayoutGuide.bottomAnchor),
            switchControl.leadingAnchor.constraint(equalTo: switchContainer.safeAreaLayoutGuide.leadingAnchor),
            switchControl.trailingAnchor.constraint(equalTo: switchContainer.safeAreaLayoutGuide.trailingAnchor)
        ])

        switchControl.leftText = "Мероприятия"
        switchControl.rightText = "Резиденты"

        switchControl.tintColor = UIColor(red: 0.22, green: 0.3, blue: 0.82, alpha: 1)
        switchControl.disabledColor = .black
        switchControl.backColor = .white

        switchControl.disabledTextColor = UIColor(red: 0.22, green: 0.23, blue: 0.27, alpha: 1)
        switchControl.selectedTextColor = .white
        
        switchControl.backgroundLayer.borderColor = UIColor(red: 0.22, green: 0.3, blue: 0.82, alpha: 1).cgColor
        switchControl.backgroundLayer.borderWidth = 2
        switchControl.switchLayer.borderColor = UIColor(red: 0.22, green: 0.3, blue: 0.82, alpha: 1).cgColor
        switchControl.switchLayer.borderWidth = 2
        switchControl.switchLayer.backgroundColor = UIColor(red: 0.22, green: 0.3, blue: 0.82, alpha: 1).cgColor

        switchControl.reloadLabelsTextColor()

        switchControl.sizeToFit()

        switchControl.addTarget(self, action: #selector(switchControlDidChangeValue(_:)), for: .valueChanged)
    }

    @objc
    private func switchControlDidChangeValue(_ switchControl: Switch) {
        pager.selectPage(at: switchControl.rightSelected ? 1 : 0)
    }

}
