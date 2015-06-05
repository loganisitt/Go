//
//  DateHeader.swift
//  Go
//
//  Created by Logan Isitt on 6/5/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit
import PureLayout
import MaterialKit

class DateHeader: UICollectionReusableView {

    var mainLabel: MKLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        
        mainLabel = MKLabel(frame: bounds)
        
        mainLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        mainLabel.textColor = UIColor.whiteColor()
        mainLabel.textAlignment = .Center
        
        mainLabel.font = UIFont.boldSystemFontOfSize(14)
        
        mainLabel.rippleLocation = MKRippleLocation.TapLocation
        mainLabel.rippleLayerColor = UIColor.grayColor()
        mainLabel.userInteractionEnabled = true
        mainLabel.backgroundAniEnabled = false
        
        mainLabel.layer.cornerRadius = 0
        mainLabel.layer.shadowOpacity = 0.55
        mainLabel.layer.shadowRadius = 0
        mainLabel.layer.shadowColor = UIColor.grayColor().CGColor
        mainLabel.layer.shadowOffset = CGSize(width: 2.5, height: 0)
        
        mainLabel.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        
        addSubview(mainLabel)
        
         layout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainLabel.frame = bounds
    }
    
    func layout() {
        mainLabel.autoPinEdgeToSuperviewEdge(.Top)
        mainLabel.autoPinEdgeToSuperviewEdge(.Left)
        mainLabel.autoPinEdgeToSuperviewEdge(.Right)
        mainLabel.autoPinEdgeToSuperviewEdge(.Bottom)
    }
}
