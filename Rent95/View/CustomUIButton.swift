//
//  CustomUIButton.swift
//  Rent95
//
//  Created by Vadym on 14.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit

//@IBDesignable
class CustomIUButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()

        setShadow()
    }
    
    func setShadow() {
        let width: CGFloat = self.bounds.width
        let height: CGFloat = self.bounds.height

        let shadowPath = UIBezierPath()
        let shadowOffsetX: CGFloat = 2000
        
        layer.shadowRadius = 0
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.05
        shadowPath.move(to: CGPoint(x: 0, y: height))
        shadowPath.addLine(to: CGPoint(x: width, y: 0))
        shadowPath.addLine(to: CGPoint(x: width + shadowOffsetX, y: 2000))
        shadowPath.addLine(to: CGPoint(x: shadowOffsetX, y: 2000))
        layer.shadowPath = shadowPath.cgPath
    }
}
