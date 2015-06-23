//
//  GOLabel.swift
//  Go
//
//  Created by Logan Isitt on 6/16/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import MaterialKit

class GOLabel: MKLabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        
        textColor = UIColor.whiteColor()
        textAlignment = .Center
        
        font = UIFont.boldSystemFontOfSize(20)
        
        layer.cornerRadius = 0
        layer.shadowOpacity = 0.55
        layer.shadowRadius = 0
        layer.shadowColor = UIColor.go_shadow_color().CGColor
        layer.shadowOffset = CGSizeMake(-1, 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
