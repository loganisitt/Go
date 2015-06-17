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
    
    let shadowOffset = CGSize(width: -1, height: 1)
    
    var titleLabel: GOLabel!
    var eventTitle: GOTextField!
    
    var privacySwitch: CustomSwitch!
    var ageSwitch: CustomSwitch!
    var ageSlider: TTRangeSlider!
    var peopleStepper: CustomStepper!
    
    var ageConstraint: NSLayoutConstraint!
    
    var eventType: EventType! {
        didSet {
            people = eventType.numOfPlayers
            if eventTitle != nil {
                eventTitle.text = "\(eventType.name) Game"
            }
        }
    }
    
    var people: Int! = 2 {
        didSet {
            if peopleStepper != nil {
                peopleStepper.place = people / peopleStepper.multiplier   
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        layoutViews()
    }
    
    // MARK: - Actions
    
    func ageRestrictionChanged() {
        ageConstraint.constant = !ageSwitch.isOff ? -ageSlider.bounds.height : -12
        if !ageSwitch.isOff {
            view.bringSubviewToFront(ageSwitch)
            ageSlider.hidden = true
        }
        else {
            view.bringSubviewToFront(ageSlider)
            ageSlider.hidden = false
        }
        UIView.animateWithDuration(0.4,
            delay: 0.0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 7.0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: { () -> Void in
                self.view.layoutIfNeeded()
            },
            completion: nil)
    }
    
    
    // MARK: - Views
    func setupViews() {
                
        titleLabel = GOLabel()
        titleLabel.text = self.title
        titleLabel.font = UIFont.boldSystemFontOfSize(20)
        
        eventTitle = GOTextField()
        eventTitle.placeholder = "Event Name"
        eventTitle.text = eventType != nil ? "\(eventType.name) Game" : ""

        privacySwitch = CustomSwitch()
        privacySwitch.offText = "Private"
        privacySwitch.onText = "Public"
        privacySwitch.centerText = "Privacy"
        
        ageSwitch = CustomSwitch()
        ageSwitch.addTarget(self, action: "ageRestrictionChanged", forControlEvents: .ValueChanged)

        ageSwitch.isOff = true
        ageSwitch.centerText = "Age Restrictions"
        
        ageSlider = TTRangeSlider()
        ageSlider.backgroundColor = UIColor.go_blue()
        ageSlider.tintColor = UIColor.go_white()
        
        ageSlider.delegate = self;
        ageSlider.minValue = 13;
        ageSlider.maxValue = 100;
        ageSlider.selectedMinimum = 18;
        ageSlider.selectedMaximum = 40;
        
        ageSlider.layer.cornerRadius = 0
        ageSlider.layer.shadowOpacity = 0.55
        ageSlider.layer.shadowRadius = 0
        ageSlider.layer.shadowColor = UIColor.go_shadow_color().CGColor
        ageSlider.layer.shadowOffset = shadowOffset
        
        peopleStepper = CustomStepper()
        peopleStepper.minValue = 2
        peopleStepper.maxValue = 22
        peopleStepper.multiplier = 2
        peopleStepper.place = people / peopleStepper.multiplier
        
        view.addSubview(eventTitle)
        view.addSubview(privacySwitch)
        view.addSubview(ageSwitch)
        view.addSubview(ageSlider)
        view.addSubview(peopleStepper)
        view.addSubview(titleLabel)
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
        
        ageConstraint = ageSlider.autoPinEdge(.Top, toEdge: .Bottom, ofView: ageSwitch, withOffset: !ageSwitch.isOff ? -70 : -12)
        ageSlider.autoPinEdgeToSuperviewEdge(.Left)
        ageSlider.autoPinEdgeToSuperviewEdge(.Right)
        ageSlider.autoSetDimension(.Height, toSize: 70)
        
        peopleStepper.autoPinEdge(.Top, toEdge: .Bottom, ofView: ageSlider, withOffset: 8)
        peopleStepper.autoPinEdgeToSuperviewEdge(.Left)
        peopleStepper.autoPinEdgeToSuperviewEdge(.Right)
        peopleStepper.autoSetDimension(.Height, toSize: 50)
    }
    
    // MARK: - TTRangeSliderDelegate
    
    func rangeSlider(sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        
    }
}