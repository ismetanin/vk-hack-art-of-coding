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

    @IBOutlet private weak var mySevIdButton: UIButton!

    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        mySevIdButton.setTitleColor(.gray, for: .highlighted)
        mySevIdButton.setTitleColor(.gray, for: .focused)
        mySevIdButton.setTitleColor(.gray, for: .selected)
    }
    

}
