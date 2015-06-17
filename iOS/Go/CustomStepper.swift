//
//  CustomStepper.swift
//  Go
//
//  Created by Logan Isitt on 6/10/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout
import MaterialKit

class CustomStepper: UIControl {

    var decButton: MKButton!
    var incButton: MKButton!
    var titleLabel: MKLabel!
    
    var place: Int = 0 {
        didSet {
            titleLabel.text = "Number of People: \(place * multiplier)"
        }
    }
    
    var multiplier: Int = 1 {
        didSet {
            titleLabel.text = "Number of People: \(place * multiplier)"
        }
    }
    
    var minValue: Int = 0 {
        didSet {
            while place * multiplier < minValue {
                place++
            }
        }
    }
    
    var maxValue: Int = 10 {
        didSet {
            while place * multiplier > minValue {
                place--
            }
        }
    }
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    // MARK: - Setup
    
    func setup() {
        
        backgroundColor = UIColor.go_blue()
        
        layer.cornerRadius = 0
        layer.shadowOpacity = 0.55
        layer.shadowRadius = 0
        layer.shadowColor = UIColor.go_shadow_color().CGColor
        layer.shadowOffset = CGSize(width: -1, height: -1)
        
        var shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: -1, height: 1)
        shadow.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
        
        decButton = MKButton()
        decButton.addTarget(self, action: "decrementButtonAction", forControlEvents: .TouchUpInside)
        
        decButton.layer.cornerRadius = 0
        
        decButton.titleLabel?.font = UIFont.ioniconOfSize(35)
        
        decButton.setTitle(String.ioniconWithName(Ionicon.Minus), forState: .Normal)
        decButton.setTitleColor(UIColor.go_white(), forState: .Normal)
        
        decButton.titleLabel?.layer.cornerRadius = 0
        decButton.titleLabel?.layer.shadowOpacity = 0.55
        decButton.titleLabel?.layer.shadowRadius = 0
        decButton.titleLabel?.layer.shadowColor = UIColor.go_shadow_color().CGColor
        decButton.titleLabel?.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        incButton = MKButton()
        incButton.addTarget(self, action: "incrementButtonAction", forControlEvents: .TouchUpInside)
        
        incButton.layer.cornerRadius = 0
        
        incButton.titleLabel?.font = UIFont.ioniconOfSize(35)
        
        incButton.setTitle(String.ioniconWithName(Ionicon.Plus), forState: .Normal)
        incButton.setTitleColor(UIColor.go_white(), forState: .Normal)
        
        incButton.titleLabel?.layer.cornerRadius = 0
        incButton.titleLabel?.layer.shadowOpacity = 0.55
        incButton.titleLabel?.layer.shadowRadius = 0
        incButton.titleLabel?.layer.shadowColor = UIColor.go_shadow_color().CGColor
        incButton.titleLabel?.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        titleLabel = MKLabel()
        
        titleLabel.textColor = UIColor.go_white()
        titleLabel.textAlignment = .Center
        
        titleLabel.font = UIFont.boldSystemFontOfSize(18)
        
        titleLabel.layer.cornerRadius = 0
        titleLabel.layer.shadowOpacity = 0.55
        titleLabel.layer.shadowRadius = 0
        titleLabel.layer.shadowColor = UIColor.go_shadow_color().CGColor
        titleLabel.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        addSubview(decButton)
        addSubview(incButton)
        addSubview(titleLabel)
    }
    
    // MARK: - Layout
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        layout()
    }
    
    func layout() {
        
        decButton.autoPinEdgeToSuperviewEdge(.Top)
        decButton.autoPinEdgeToSuperviewEdge(.Left)
        decButton.autoPinEdgeToSuperviewEdge(.Bottom)
        decButton.autoSetDimension(.Width, toSize: bounds.height)

        incButton.autoPinEdgeToSuperviewEdge(.Top)
        incButton.autoPinEdgeToSuperviewEdge(.Right)
        incButton.autoPinEdgeToSuperviewEdge(.Bottom)
        incButton.autoSetDimension(.Width, toSize: bounds.height)
        
        titleLabel.autoPinEdgeToSuperviewEdge(.Top)
        titleLabel.autoPinEdgeToSuperviewEdge(.Bottom)
        titleLabel.autoPinEdge(.Left, toEdge: .Right, ofView: decButton)
        titleLabel.autoPinEdge(.Right, toEdge: .Left, ofView: incButton)
    }
    
    // MARK: - Actions
    
    func decrementButtonAction() {
        if (place - 1) * multiplier >= minValue {
            place--
        }
    }
    
    func incrementButtonAction() {
        if (place + 1) * multiplier <= maxValue {
            place++
        }
    }
}
