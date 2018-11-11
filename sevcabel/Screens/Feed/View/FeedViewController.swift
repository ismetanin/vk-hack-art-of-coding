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
            FeedItem(title: "Big Resale Weekend",
                     subtitle: "через 2 дня",
                     image: UIImage(named: "big_resale")!,
                     fullImage: UIImage(named: "big_resale_full")!,
                     description: """
                Что делать:
                — бесплатно послушать лекции от ведущих историков и культурологов моды (Марина Скульская, Мэган Виртанен, Варя Веденеева, Ксения Мозговая, Алексей Баженов)
                — продать свои ненужные вещи или сдать их на продажу в пользу подопечных фонда AdVita
                — найти абсолютные сокровища за смешные деньги от лучших комиссионных и винтажных магазинов Петербурга.
                — слушать музыку, смотреть инсталляции и объекты искусства
                — отлично провести время и узнать, как сделать свою ежедневную жизнь проще, приятнее, осознанней!

                Для кого:
                всех и каждого, вход свободный!
                """,
                     isEvent: true
            ),
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
                     isEvent: true
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
                     isEvent: true
            )
        ]

        let items2: [FeedItem] = [
            FeedItem(title: "Devil Taco",
                     subtitle: "Стритфуд",
                     image: UIImage(named: "devil_taco")!,
                     fullImage: UIImage(named: "devil_taco_full")!,
                     description: """
                    БАР ДЬЯВОЛЬСКИХ ТАКО
                    Простите , это шутка 👹
                    Приходите к нам на Тако!
                    /
                    Самые острые,
                    Самые сочные,
                    Самые свежие,
                    И убойные,
                    Дэвил тако
                    /
                    Бертгольд центр - каждый день
                    Порт Севкабель - по выходным
                    """,
                     isEvent: false
            )
        ]

        let vc1 = FeedBlockViewController()
        vc1.configure(with: items1)
        vc1.didSelectItem = { [weak self] item in
            guard let vc = FeedItemDetailViewController.fromStoryboard() as? FeedItemDetailViewController else {
                return
            }
            vc.configure(with: item)
            self?.present(vc, animated: true, completion: nil)
        }

        let vc2 = FeedBlockViewController()
        vc2.configure(with: items2)
        vc2.didSelectItem = { [weak self] item in
            guard let vc = FeedItemDetailViewController.fromStoryboard() as? FeedItemDetailViewController else {
                return
            }
            vc.configure(with: item)
            self?.present(vc, animated: true, completion: nil)
        }

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

        switchControl.tintColor = UIColor(red: 0.17, green: 0.22, blue: 0.56, alpha: 1)
        switchControl.disabledColor = .black
        switchControl.backColor = .white

        switchControl.disabledTextColor = UIColor(red: 0.22, green: 0.23, blue: 0.27, alpha: 1)
        switchControl.selectedTextColor = .white
        
        switchControl.backgroundLayer.borderColor = UIColor(red: 0.17, green: 0.22, blue: 0.56, alpha: 1).cgColor
        switchControl.backgroundLayer.borderWidth = 2
        switchControl.switchLayer.borderColor = UIColor(red: 0.17, green: 0.22, blue: 0.56, alpha: 1).cgColor
        switchControl.switchLayer.borderWidth = 2
        switchControl.switchLayer.backgroundColor = UIColor(red: 0.17, green: 0.22, blue: 0.56, alpha: 1).cgColor

        switchControl.reloadLabelsTextColor()

        switchControl.sizeToFit()

        switchControl.addTarget(self, action: #selector(switchControlDidChangeValue(_:)), for: .valueChanged)
    }

    @objc
    private func switchControlDidChangeValue(_ switchControl: Switch) {
        pager.selectPage(at: switchControl.rightSelected ? 1 : 0)
    }

}
