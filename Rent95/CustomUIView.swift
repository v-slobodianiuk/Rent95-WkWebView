//
//  CustomUIView.swift
//  Rent95
//
//  Created by Vadym on 14.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit

//@IBDesignable
class CustomUIView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()

        self.clipsToBounds = true
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        self.alpha = 0.8
    }
    
}
