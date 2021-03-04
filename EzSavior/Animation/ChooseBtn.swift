//
//  ChooseBtn.swift
//  EzSavior
//
//  Created by Hatto on 30/11/2563 BE.
//

import UIKit

@IBDesignable
class ChooseBtn: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var isEnabledInitFromAnimation: Bool = true
    
    @IBInspectable public var shadowOpacity: Float = 0
        {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable public var shadowColor: UIColor = UIColor.clear
        {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable public var shadowRadius: CGFloat = 0
        {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable public var shadowOffset: CGSize = CGSize(width: 0, height: 0)
        {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
}
