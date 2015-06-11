//
//  PickSettingsViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/9/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout

import MaterialKit
import TTRangeSlider

class PickSettingsViewController: UIViewController, TTRangeSliderDelegate {
    
    var titleLabel: UILabel!
    var eventTitle: MKTextField! // Alternative Title
    
    var privacySwitch: CustomSwitch! // Privacy (Public or Private)
    var ageSwitch: CustomSwitch! //
    var ageSlider: TTRangeSlider!
    var peopleStepper: CustomStepper! // Number of People (Slider)
    
    var ageConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        layoutViews()
    }
    
    // MARK: - Actions
    
    func ageRestrictionChanged() {
        ageConstraint.constant = !ageSwitch.isOff ? -40 : 20
    }
    
    
    // MARK: - Views
    func setupViews() {
        
        let padding = CGSizeMake(21, 21)
        
        titleLabel = UILabel()
        titleLabel.text = self.title
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        
        titleLabel.font = UIFont.boldSystemFontOfSize(20)
        
        titleLabel.backgroundColor = UIColor(red: 0, green: 177.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        
        eventTitle = MKTextField()
        
        eventTitle.layer.borderColor = UIColor.clearColor().CGColor
        eventTitle.floatingPlaceholderEnabled = true
        eventTitle.placeholder = "Event Name"
        eventTitle.rippleLayerColor = UIColor.grayColor()
        eventTitle.backgroundColor = UIColor(hex: 0xEEEEEE)
        eventTitle.padding = padding
        eventTitle.layer.cornerRadius = 0
        eventTitle.bottomBorderEnabled = true
        eventTitle.bottomBorderHighlightWidth = eventTitle.bottomBorderWidth
        eventTitle.tintColor = eventTitle.bottomBorderColor

        privacySwitch = CustomSwitch()
        privacySwitch.offText = "Private"
        privacySwitch.onText = "Public"
        privacySwitch.centerText = "Privacy"
        
        ageSwitch = CustomSwitch()
        ageSwitch.isOff = true

        ageSwitch.offText = "Off"
        ageSwitch.onText = "On"
        ageSwitch.centerText = "Age Restrictions"
        
        ageSwitch.addTarget(self, action: "ageRestrictionChanged", forControlEvents: .ValueChanged)
        
        ageSlider = TTRangeSlider()
        
        ageSlider.delegate = self;
        ageSlider.minValue = 13;
        ageSlider.maxValue = 100;
        ageSlider.selectedMinimum = 18;
        ageSlider.selectedMaximum = 40;
        
        peopleStepper = CustomStepper()
        
        view.addSubview(titleLabel)
        view.addSubview(eventTitle)
        view.addSubview(privacySwitch)
        view.addSubview(ageSlider)
        view.addSubview(ageSwitch)
        view.addSubview(peopleStepper)
    }
    
    // MARK: - Layout
    
    func layoutViews() {
        
        titleLabel.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left)
        titleLabel.autoPinEdgeToSuperviewEdge(.Right)
        titleLabel.autoSetDimension(.Height, toSize: 50)

        eventTitle.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: 8)
        eventTitle.autoPinEdgeToSuperviewEdge(.Left)
        eventTitle.autoPinEdgeToSuperviewEdge(.Right)
        eventTitle.autoSetDimension(.Height, toSize: 50)
        
        privacySwitch.autoPinEdge(.Top, toEdge: .Bottom, ofView: eventTitle, withOffset: 8)
        privacySwitch.autoPinEdgeToSuperviewEdge(.Left)
        privacySwitch.autoPinEdgeToSuperviewEdge(.Right)
        privacySwitch.autoSetDimension(.Height, toSize: 50)
        
        ageSwitch.autoPinEdge(.Top, toEdge: .Bottom, ofView: privacySwitch, withOffset: 8)
        ageSwitch.autoPinEdgeToSuperviewEdge(.Left)
        ageSwitch.autoPinEdgeToSuperviewEdge(.Right)
        ageSwitch.autoSetDimension(.Height, toSize: 50)
        
        ageConstraint = ageSlider.autoPinEdge(.Top, toEdge: .Bottom, ofView: ageSwitch, withOffset: !ageSwitch.isOff ? -40 : 20)
        ageSlider.autoPinEdgeToSuperviewEdge(.Left)
        ageSlider.autoPinEdgeToSuperviewEdge(.Right)
        ageSlider.autoSetDimension(.Height, toSize: 40)
        
        peopleStepper.autoPinEdge(.Top, toEdge: .Bottom, ofView: ageSlider, withOffset: 8)
        peopleStepper.autoPinEdgeToSuperviewEdge(.Left)
        peopleStepper.autoPinEdgeToSuperviewEdge(.Right)
        peopleStepper.autoSetDimension(.Height, toSize: 50)
    }
    
    // MARK: - TTRangeSliderDelegate
    
    func rangeSlider(sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        
    }
}