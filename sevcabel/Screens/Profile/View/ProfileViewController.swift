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
        didSelectItem = { [weak self] item in
            guard let vc = FeedItemDetailViewController.fromStoryboard() as? FeedItemDetailViewController else {
                return
            }
            vc.configure(with: item)
            self?.present(vc, animated: true, completion: nil)
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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
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
    }

    private func configure(with user: User) {
        DispatchQueue.main.async {
            self.header.configure(with: user)
            self.fillTableWithItems()
        }
    }

    private func fillTableWithItems() {
        let items: [FeedItem] = [
            FeedItem(title: "Сольный концерт певицы Нины Карлссон",
                     subtitle: "13 декабря",
                     image: UIImage(named: "nina")!,
                     fullImage: UIImage(named: "nina_full")!,
                     description: """
                Музыка Нины Карлссон — утонченный и эмоциональный синтез блюза, джаза, кабаре и рока. Среди её последних экспериментов — фольклорные мотивы в музыке и остроумные тексты с «двойным дном».

                За время своей карьеры Нина записывала англо- и русскоязычные альбомы и выступала на множестве фестивалей. В 2017 году певица открывала кинофестиваль «Кинотавр», ее музыка стала саундтреком для выставки и фильма Евгения Гранильщикова «В предрассветный час наши сны становятся ярче». Сама Нина стала главной героиней фильма.

                Специально для наших подписчиков действует специальный промокод с 50%-ной скидкой при покупке билета: PORTSEVCABFRIENDPSGX3Q.
                Код действителен на первые 50 активаций👇
                """,
                     isEvent: true,
                     isRegistered: true
            ),
            FeedItem(title: "One Love Fest",
                     subtitle: "Со 2 по 3 января",
                     image: UIImage(named: "one_love")!,
                     fullImage: UIImage(named: "one_love_full")!,
                     description: """
                    2-3 января — первый зимний музыкальный фестиваль One Love Fest в «Порт Севкабель».

                    Новый Год 2019 официально продлен до завершения One Love Fest! Марафон двухдневного веселья с весомым лайн-апом на двух сценах, зонами фудкорта и баров от нишевых, ламповых, и востребованных заведений Петербурга. А также выставка художников «Срез», которая объединит 30 художников по направлению street art, медиа и современное искусство.

                    — 2 января: Нигатив, Snowgoons, Kurovoi, Dj Row-Man, DJ Tactics, Dj Komar, Dj Shubin, Iggaz, Dj Smirnoff, Pasha Bronx, Alex Osadchi, Boogie Fek, DJ Worm & more TBA.

                    — 3 января: Луна, Pompeya, СБПЧ, Меджикул, Mujuice, Cream Soda, TANTSUI, Союз, Тося Чайкина, List, Andrei Panin, Feodor Allright, Primat, Juravlove, Saktu, Kimbar, Timofey.

                    One Love Fest — альтернативный ответ на вопрос, над которым бьются лучшие умы человечества, «чем заняться в новогодние каникулы?». 💕
                    """,
                     isEvent: true,
                     isRegistered: true
            )
        ]
        self.configure(with: items)
    }

}
