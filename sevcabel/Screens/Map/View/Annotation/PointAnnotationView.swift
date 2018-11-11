//
//  PointAnnotationView.swift
//  sevcabel
//
//  Created by Anton Dryakhlykh on 11/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Mapbox

final class PointAnnotationView: MGLAnnotationView {

    // MARK: - Enums

    private enum Constants {
        static let pulseRadius: CGFloat = 48.0
        static let pulseColor = UIColor(red: 0.99, green: 0.1, blue: 0.37, alpha: 1.0)
        static let animationDuration = 0.8
    }

    // MARK: - Constants

    private let image: UIImage?

    // MARK: - Initialization and deinitialization

    init(image: UIImage?) {
        self.image = image
        super.init(frame: .zero)
        configureAppearance()
    }

    required init?(coder aDecoder: NSCoder) {
        self.image = nil
        super.init(coder: aDecoder)
    }

    // MARK: - Private helpers

    private func configureAppearance() {
        let imageView = UIImageView(image: image)
        imageView.frame.size = image?.size ?? .zero
        frame = imageView.frame
        addSubview(imageView)

        let pulse = PulseLayer(radius: Constants.pulseRadius, position: imageView.center)
        pulse.animationDuration = Constants.animationDuration
        pulse.backgroundColor = Constants.pulseColor.cgColor

        layer.insertSublayer(pulse, below: imageView.layer)
    }
}
