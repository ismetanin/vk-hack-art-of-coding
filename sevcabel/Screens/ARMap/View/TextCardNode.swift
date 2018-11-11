//
//  TextCardNode.swift
//  ARKit+CoreLocation
//
//  Created by Gregory Berngardt on 10/11/2018.
//  Copyright © 2018 Project Dent. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit
import CoreLocation
import ARCL

extension UIView {
    func image() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.insetBy(dx: -5.0, dy: -5.0).size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}

extension String {
    func heightForString(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
}

open class TextCardNode: LocationAnnotationNode {
    
    public let title: String
    
    public let summary: String
    
    public init(location: CLLocation?, title: String, summary: String?, urgencyLevel: Int = 0) {
        
        self.title = title
        self.summary = summary ?? ""
        
        let resultWidth: CGFloat = 240.0
        let textWidth: CGFloat = resultWidth - 20.0
        let verticalSpacing: CGFloat = 8.0 + 3.0 + 8.0
        let titleHeight = self.title.heightForString(withConstrainedWidth: textWidth)
        let summaryHeight = self.summary.heightForString(withConstrainedWidth: textWidth)
        let resultHeight = titleHeight + summaryHeight + verticalSpacing

        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: resultWidth, height: resultHeight))
        
        let color = { () -> UIColor in
            switch urgencyLevel {
            case 1: return UIColor(red: 0.17, green: 0.22, blue: 0.56, alpha: 1)
            case 2: return UIColor(red: 0.98, green: 0.1, blue: 0.37, alpha: 1)
            default: return UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            }
        }()
        
        view.backgroundColor = color
        view.layer.cornerRadius = 10.0
        
        let titleLabel = UILabel(frame: CGRect(x: 10.0, y: 8.0, width: textWidth, height: titleHeight))
        titleLabel.numberOfLines = 0
        titleLabel.text = self.title
        titleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        titleLabel.textColor = UIColor.init(white: 1.0, alpha: 0.5)
        titleLabel.sizeToFit()
        
        let summaryLabel = UILabel(frame: CGRect(x: 10.0, y: titleLabel.frame.maxY + 3.0, width: textWidth, height: summaryHeight))
        summaryLabel.numberOfLines = 0
        summaryLabel.text = self.summary
        summaryLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        summaryLabel.textColor = UIColor.init(white: 1.0, alpha: 1.0)
        summaryLabel.sizeToFit()
        
        view.frame = CGRect(x: 0.0, y: 0.0, width: resultWidth, height: summaryLabel.frame.maxY + 8.0)
        
        view.addSubview(titleLabel)
        view.addSubview(summaryLabel)
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.5, height: 4.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 5.0
        
        let image = view.image()
        
        super.init(location: location, image: image ?? UIImage())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
