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

    // MARK: - Private methods

    private func configurePageController() {
        let items1: [FeedItem] = [
            FeedItem(image: UIImage(named: "big_resale")!, title: "Big Resale Weekend", subtitle: "через 2 дня"),
            FeedItem(image: UIImage(named: "big_resale")!, title: "Праздник для корги", subtitle: "24 ноября"),
            FeedItem(image: UIImage(named: "big_resale")!, title: "Сольный концерт певицы Нины Карлссон", subtitle: "13 декабря"),
            FeedItem(image: UIImage(named: "big_resale")!, title: "One Love Fest", subtitle: "Со 2 по 3 января")
        ]

        let items2: [FeedItem] = [
            FeedItem(image: UIImage(named: "devil_taco")!, title: "Big Resale Weekend", subtitle: "через 2 дня"),
            FeedItem(image: UIImage(named: "devil_taco")!, title: "Праздник для корги", subtitle: "24 ноября"),
            FeedItem(image: UIImage(named: "devil_taco")!, title: "Сольный концерт певицы Нины Карлссон", subtitle: "13 декабря"),
            FeedItem(image: UIImage(named: "devil_taco")!, title: "One Love Fest", subtitle: "Со 2 по 3 января")
        ]

        let vc1 = FeedBlockViewController()
        vc1.configure(with: items1)

        let vc2 = FeedBlockViewController()
        vc2.configure(with: items2)

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
