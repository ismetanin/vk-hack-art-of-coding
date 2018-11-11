//
//  StringAttributes.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 11/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation
import UIKit

/// Attributes for string.
enum StringAttribute {
    /// Text line height
    case lineHeight(CGFloat)
    /// Letter spacing
    case kern(CGFloat)
    /// Text font
    case font(UIFont)
    /// Text foreground (letter) color
    case foregroundColor(UIColor)
    /// Text aligment
    case aligment(NSTextAlignment)

    fileprivate var attributeKey: NSAttributedString.Key {
        switch self {
        case .lineHeight, .aligment:
            return NSAttributedString.Key.paragraphStyle
        case .kern:
            return NSAttributedString.Key.kern
        case .font:
            return NSAttributedString.Key.font
        case .foregroundColor:
            return NSAttributedString.Key.foregroundColor
        }
    }

    fileprivate var value: Any {
        switch self {
        case .lineHeight(let value):
            return value
        case .kern(let value):
            return value
        case .font(let value):
            return value
        case .foregroundColor(let value):
            return value
        case .aligment(let value):
            return value
        }
    }

}

extension String {

    /// Apply attributes to string and returns new attributes string
    func string(with attributes: [StringAttribute]) -> NSAttributedString {
        let resultAttributes = buildAttributes(from: attributes)
        return NSAttributedString(string: self, attributes: resultAttributes)
    }

    func mutableString(with attributes: [StringAttribute]) -> NSMutableAttributedString {
        let resultAttributes = buildAttributes(from: attributes)
        return NSMutableAttributedString(string: self, attributes: resultAttributes)
    }

    private func buildAttributes(from attributes: [StringAttribute]) -> [NSAttributedString.Key: Any] {
        var resultAttributes = [NSAttributedString.Key: Any]()
        let paragraph = NSMutableParagraphStyle()

        for attribute in attributes {
            switch attribute {
            case .lineHeight(let value):
                paragraph.lineSpacing = value
                resultAttributes[attribute.attributeKey] = paragraph
            case .aligment(let value):
                paragraph.alignment = value
                resultAttributes[attribute.attributeKey] = paragraph
            default:
                resultAttributes[attribute.attributeKey] = attribute.value
            }
        }

        return resultAttributes
    }

}
