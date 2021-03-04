//
//  AddButton.swift
//  EzSavior
//
//  Created by Hatto on 30/11/2563 BE.
//

import UIKit
import QuartzCore

@IBDesignable
class AddButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
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
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        if self.imageView?.transform == .identity {
            UIView.animate(withDuration: 0.50, animations: {
                self.imageView?.transform = CGAffineTransform(rotationAngle: 45 * (.pi / 180))
            }) { (completion) in
                
            }
        } else {
            UIView.animate(withDuration: 0.50, delay: 0.6, animations: {
                self.imageView?.transform = .identity
            }) { (completion) in
            }
        }
        super.layoutSubviews()
        return super.beginTracking(touch, with: event)
    }

}
