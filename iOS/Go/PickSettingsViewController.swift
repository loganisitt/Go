//
//  PickSettingsViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/9/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout

import Suitchi

class PickSettingsViewController: UIViewController {
    
    var titleLabel: UILabel!
    
    // Alternative Title
    var privacySwitch: CustomSwitch! // Privacy (Public or Private)
    // Age Restriction (Slider)
    // Number of People (Slider)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        layoutViews()
    }
    
    // MARK: - Views
    func setupViews() {
        
        titleLabel = UILabel()
        titleLabel.text = self.title
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        
        titleLabel.font = UIFont.boldSystemFontOfSize(20)
        
        titleLabel.backgroundColor = UIColor(red: 0, green: 177.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        
        privacySwitch = CustomSwitch()
        
        view.addSubview(titleLabel)
        view.addSubview(privacySwitch)
    }
    
    // MARK: - Layout
    
    func layoutViews() {
        titleLabel.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left)
        titleLabel.autoPinEdgeToSuperviewEdge(.Right)
        titleLabel.autoSetDimension(.Height, toSize: 50)
        
        privacySwitch.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: 8)
        privacySwitch.autoPinEdgeToSuperviewEdge(.Left)
        privacySwitch.autoPinEdgeToSuperviewEdge(.Right)
        privacySwitch.autoSetDimension(.Height, toSize: 50)
    }
}
