//
//  GOTextField.swift
//  Go
//
//  Created by Logan Isitt on 6/4/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit
import MaterialKit

class GOTextField: MKTextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        let padding = CGSizeMake(21, 21)

        layer.borderColor = UIColor.clearColor().CGColor
        floatingPlaceholderEnabled = true
        rippleLayerColor = UIColor.grayColor()
        backgroundColor = UIColor(hex: 0xEEEEEE)
        self.padding = padding
        layer.cornerRadius = 0
        bottomBorderEnabled = true
        bottomBorderHighlightWidth = bottomBorderWidth
        tintColor = bottomBorderColor
    }
}
