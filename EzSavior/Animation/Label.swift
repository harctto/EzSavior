//
//  Label.swift
//  EzSavior
//
//  Created by Hatto on 30/11/2563 BE.
//

import UIKit

@IBDesignable
class Label: UILabel {

    @IBInspectable var backgroundColorValue: UIColor = UIColor.lightGray {
        didSet {
            layer.backgroundColor = backgroundColorValue.cgColor
        }
    }
    
    @IBInspectable public var shadowOpacity: Float = 0
        {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    @IBInspectable public var shadowRadius: CGFloat = 0
        {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable public var shadowOffset1: CGSize = CGSize(width: 0, height: 0)
        {
        didSet {
            layer.shadowOffset = shadowOffset1
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
