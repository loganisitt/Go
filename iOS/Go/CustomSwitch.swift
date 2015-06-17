//
//  CustomSwitch.swift
//  Custom Switch
//
//  Created by Chad Timmerman on 3/4/15.
//  Copyright (c) 2015 Chad Timmerman. All rights reserved.
//

import UIKit

import MaterialKit

class CustomSwitch: UIControl {
    
    var backgroundView: UIView!
    
    var onButton: MKButton!
    var offButton: MKButton!
    var buttonWindow: UIView!
    
    var onLabel: MKLabel!
    var offLabel: MKLabel!
    var centerCircleLabel: MKLabel!
    
    let whiteColor = UIColor.go_white()
    let darkGreyColor = UIColor.go_blue()
    
    var isOff: Bool = true {
        didSet {
            if isOff {
                if offLabel != nil && onLabel != nil {
                    offLabel.layer.shadowColor = UIColor.go_shadow_color().CGColor
                    onLabel.layer.shadowColor = UIColor.go_white().CGColor
                }
            }
            else {
                if offLabel != nil && onLabel != nil {
                    offLabel.layer.shadowColor = UIColor.go_white().CGColor
                    onLabel.layer.shadowColor = UIColor.go_shadow_color().CGColor
                }
            }
        }
    }
    
    var offText: String = "Off" {
        didSet {
            if offLabel != nil {
                offLabel.text = offText
            }
        }
    }
    
    var onText: String = "On" {
        didSet {
            if onLabel != nil {
                onLabel.text = onText
            }
        }
    }
    
    var centerText: String = "or" {
        didSet {
            if centerCircleLabel != nil {
                centerCircleLabel.text = centerText
            }
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        backgroundView = UIView()
        backgroundView.frame = self.bounds
        backgroundView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        backgroundView.layer.cornerRadius = 0 // 4.0
        self.addSubview(backgroundView)
        
        // Setup the Sliding Window
        
        buttonWindow = UIView()
        buttonWindow.frame = CGRectMake(0.0, 0.0, self.bounds.size.width / 2, self.bounds.size.height)
        buttonWindow.backgroundColor = darkGreyColor
        buttonWindow.layer.cornerRadius = 0 // 4.0
        self.addSubview(buttonWindow)
        
        // Setup the Buttons
        
        onButton = MKButton()
        onButton.frame = CGRectMake(0.0, 0.0, self.bounds.size.width / 2, self.bounds.size.height)
        onButton.backgroundColor = UIColor.clearColor()
        onButton.enabled = false
        onButton.addTarget(self, action: "toggleSwitch:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(onButton)
        
        offButton = MKButton()
        offButton.frame = CGRectMake(self.bounds.size.width / 2, 0.0, self.bounds.size.width / 2, self.bounds.size.height)
        offButton.backgroundColor = UIColor.clearColor()
        offButton.enabled = true
        offButton.addTarget(self, action: "toggleSwitch:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(offButton)
        
        // Setup the Labels
        
        onLabel = MKLabel()
        onLabel.frame = CGRectMake(0.0, (self.bounds.size.height / 2) - 25.0, self.bounds.size.width / 2, 50.0)
        onLabel.alpha = 1.0
        onLabel.text = onText
        onLabel.textAlignment = NSTextAlignment.Center
        onLabel.textColor = whiteColor
        onLabel.font = UIFont.boldSystemFontOfSize(14)
        onButton.addSubview(onLabel)
        
        onLabel.layer.cornerRadius = 0
        onLabel.layer.shadowOpacity = 0.55
        onLabel.layer.shadowRadius = 0
        onLabel.layer.shadowColor = UIColor.go_shadow_color().CGColor
        onLabel.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        offLabel = MKLabel()
        offLabel.frame = CGRectMake(0.0, (self.bounds.size.height / 2) - 25.0, self.bounds.size.width / 2, 50.0)
        offLabel.alpha = 1.0
        offLabel.text = offText
        offLabel.textAlignment = NSTextAlignment.Center
        offLabel.textColor = darkGreyColor
        offLabel.font = UIFont.boldSystemFontOfSize(14)
        offButton.addSubview(offLabel)
        
        offLabel.layer.cornerRadius = 0
        offLabel.layer.shadowOpacity = 0.55
        offLabel.layer.shadowRadius = 0
        offLabel.layer.shadowColor = UIColor.go_shadow_color().CGColor
        offLabel.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        // Set up the center Label
        
        centerCircleLabel = MKLabel()
        centerCircleLabel.text = centerText
        centerCircleLabel.sizeToFit()
        centerCircleLabel.frame = CGRectMake((self.bounds.size.width / 2.0) - centerCircleLabel.bounds.width / 2.0, (self.bounds.size.height / 2.0) - centerCircleLabel.bounds.height / 2.0, centerCircleLabel.bounds.size.width, centerCircleLabel.bounds.size.height)
        centerCircleLabel.frame = CGRectInset(centerCircleLabel.frame, -4, -4)

        centerCircleLabel.textColor = UIColor.go_white()
        centerCircleLabel.textAlignment = NSTextAlignment.Center
        
        var shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: -1, height: 1)
        shadow.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
        
        centerCircleLabel.attributedText = NSAttributedString(string: centerText, attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(16),  NSShadowAttributeName: shadow])

        centerCircleLabel.backgroundColor = UIColor.go_blue()
        centerCircleLabel.clipsToBounds = true
        self.addSubview(centerCircleLabel)
        
        isOff = false
        
        layer.cornerRadius = 0
        layer.shadowOpacity = 0.55
        layer.shadowRadius = 0
        layer.shadowColor = UIColor.go_shadow_color().CGColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
    }
    
    func toggleSwitch(sender: UIButton) {
        onOrOff(!isOff)
    }
    
    func onOrOff(on : Bool){
        
        if(on == isOff){
            return
        }
        
        sendActionsForControlEvents(.ValueChanged)
        
        isOff = on
        
        UIView.animateWithDuration(0.4,
            delay: 0.0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 14.0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: { () -> Void in
                self.buttonWindow.frame.origin.x += self.frame.size.width / 2 * (on ? 1 : -1)
            },
            completion: nil)
        
        animateLabel(self.offLabel, toColor: (on ? whiteColor : darkGreyColor))
        animateLabel(self.onLabel, toColor: (on ? darkGreyColor : whiteColor))
        
        self.onButton.enabled = !self.onButton.enabled
        self.offButton.enabled = !self.offButton.enabled
        
    }
    
    private func animateLabel(label : UILabel!, toColor : UIColor){
        UIView.transitionWithView(label,
            duration: 0.4,
            options: UIViewAnimationOptions.CurveEaseOut |
                UIViewAnimationOptions.TransitionCrossDissolve |
                UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () -> Void in
                label.textColor = toColor
            },
            completion: nil)
    }
}