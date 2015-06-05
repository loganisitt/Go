//
//  DateCell.swift
//  Go
//
//  Created by Logan Isitt on 6/4/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout
import MaterialKit

class DateCell: UICollectionViewCell {

    var mainLabel: MKLabel!
    var topLabel: MKLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        mainLabel = MKLabel()
        
        mainLabel.text = "19"
        mainLabel.textColor = UIColor.whiteColor()
        mainLabel.textAlignment = .Center
        
        mainLabel.font = UIFont.boldSystemFontOfSize(26)
        
        mainLabel.rippleLocation = MKRippleLocation.TapLocation
        mainLabel.rippleLayerColor = UIColor.grayColor()
        mainLabel.userInteractionEnabled = true
        mainLabel.backgroundAniEnabled = false
        
        mainLabel.layer.cornerRadius = 0
        mainLabel.layer.shadowOpacity = 0.55
        mainLabel.layer.shadowRadius = 0
        mainLabel.layer.shadowColor = UIColor.grayColor().CGColor
        mainLabel.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        
        addSubview(mainLabel)
        
        topLabel = MKLabel()
        
        topLabel.text = "Tue"
        topLabel.textColor = UIColor.whiteColor()
        topLabel.textAlignment = .Center
        
        topLabel.font = UIFont.boldSystemFontOfSize(12)
        
        topLabel.rippleLocation = MKRippleLocation.TapLocation
        topLabel.rippleLayerColor = UIColor.grayColor()
        topLabel.userInteractionEnabled = true
        topLabel.backgroundAniEnabled = false
        
        topLabel.layer.cornerRadius = 0
        topLabel.layer.shadowOpacity = 0.55
        topLabel.layer.shadowRadius = 0
        topLabel.layer.shadowColor = UIColor.grayColor().CGColor
        topLabel.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        
        addSubview(topLabel)
        
        layout()
    }
    
    func layout() {
        topLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: 4)
        topLabel.autoPinEdgeToSuperviewEdge(.Left)
        topLabel.autoPinEdgeToSuperviewEdge(.Right)
        
        mainLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: topLabel, withOffset: 2)
        mainLabel.autoPinEdgeToSuperviewEdge(.Left)
        mainLabel.autoPinEdgeToSuperviewEdge(.Right)
        mainLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 8)
    }
}
