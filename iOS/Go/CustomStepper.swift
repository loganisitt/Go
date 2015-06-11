//
//  CustomStepper.swift
//  Go
//
//  Created by Logan Isitt on 6/10/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout

class CustomStepper: UIControl {

    var decButton: UIButton!
    var incButton: UIButton!
    var titleLabel: UILabel!
    
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
        backgroundColor = UIColor.whiteColor()
        
        decButton = UIButton.buttonWithType(.Custom) as! UIButton
        
        decButton.backgroundColor = UIColor.darkGrayColor()
        
        decButton.setTitle("-", forState: .Normal)
        decButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        incButton = UIButton.buttonWithType(.Custom) as! UIButton
        
        incButton.backgroundColor = UIColor.darkGrayColor()
        
        incButton.setTitle("+", forState: .Normal)
        incButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        titleLabel = UILabel()
        
        titleLabel.backgroundColor = UIColor.lightGrayColor()
        
        titleLabel.text = "Number: "
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        
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
}
