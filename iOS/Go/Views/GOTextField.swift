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
        let shadowOffset = CGSizeMake(-1, 1)

        backgroundColor = UIColor.go_white()
        tintColor = bottomBorderColor
        
        floatingPlaceholderEnabled = true
        rippleLayerColor = UIColor.go_blue()
        
        bottomBorderEnabled = true
        bottomBorderHighlightWidth = bottomBorderWidth
        bottomBorderColor = UIColor.go_blue()
        
        layer.borderColor = UIColor.clearColor().CGColor
        
        layer.cornerRadius = 0
        layer.shadowOpacity = 0.55
        layer.shadowRadius = 0
        layer.shadowColor = UIColor.go_shadow_color().CGColor
        layer.shadowOffset = shadowOffset
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.padding = CGSize(width: 21, height: 21)
    }
}
