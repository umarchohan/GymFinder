//
//  RoundImage.swift
//  CampusCulture
//
//  Created by Azfal, Umar on 5/7/19.
//  Copyright © 2019 CodeXpirit. All rights reserved.
//

import UIKit

class RoundImage: UIImageView {

    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor(hex: "0xEEEEEE")! {
        didSet {
            
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }
    
    // MARK: Setup
    private func setupLayer()
    {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: .zero, size: self.frame.size)
        gradient.colors = [UIColor(red: 0, green: 1, blue: 1, alpha: 1).cgColor, UIColor(red: 0, green: 103/255.0, blue: 179/255.0, alpha: 1).cgColor]

        gradient.cornerRadius = self.cornerRadius
        gradient.borderWidth = self.borderWidth
        
        let path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: 0, dy: 0), byRoundingCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: frame.size.height / 2, height: frame.size.height / 2)).cgPath
        
        let shape = CAShapeLayer()
        shape.lineWidth = 1
        shape.cornerRadius = self.cornerRadius
        shape.path = path
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape

        self.layer.addSublayer(gradient)
        
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.masksToBounds = true
        
        
    }
    
}
