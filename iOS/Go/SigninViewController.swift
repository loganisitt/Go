//
//  SigninViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/3/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout

import FBSDKCoreKit
import FBSDKLoginKit

import MaterialKit

class SigninViewController: UIViewController {
    
    var appName: MKLabel!
    
    var emailField: MKTextField!
    var passwordField: MKTextField!
    var forgotButton: MKButton!
   
    var emailLoginButton: SNButton!
    var facebookLoginButton: SNButton!
    var twitterLoginButton: SNButton!

    var exitButton: MKButton!
    
    // MARK: - General
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 177.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
        }
        
        navigationController?.navigationBar.hidden = true
        
        addBackground()
        setupViews()
        
        layoutSubviews()
        
        // Gestures
        
        let singleTap = UITapGestureRecognizer(target: self, action: Selector("resignFirstResponders"))
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("resignFirstResponders"))
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(downSwipe)
    }
    
    // MARK: - Actions
    
    func exitButtonAction() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func facebookButtonAction() {
        performSegueWithIdentifier("gotoDash", sender: self)
    }
    
    func resignFirstResponders() {
        
        for v in view.subviews {
            if v.isFirstResponder() {
                v.resignFirstResponder()
            }
        }
    }
    
    // MARK: - Views
    
    func addBackground() {
        
        var backgroundView = UIImageView(image: UIImage(named: "background"))
        view.addSubview(backgroundView)
        
        backgroundView.contentMode = .ScaleAspectFill
        
        backgroundView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
    }
    
    func setupViews() {
        
        let padding = CGSizeMake(21, 21)
        
        exitButton = MKButton()
        exitButton.addTarget(self, action: "exitButtonAction", forControlEvents: .TouchUpInside)
        
        exitButton.setTitle(String.fontAwesomeIconWithName(.Times), forState: .Normal)
        exitButton.titleLabel?.font = UIFont.fontAwesomeOfSize(40)
        exitButton.maskEnabled = false
        exitButton.ripplePercent = 1.2
        exitButton.rippleLocation = .Center
        exitButton.backgroundAniEnabled = false
        
        exitButton.rippleLayerColor = UIColor.grayColor()
        
        exitButton.layer.cornerRadius = 0
        exitButton.layer.shadowOpacity = 0.55
        exitButton.layer.shadowRadius = 0
        exitButton.layer.shadowColor = UIColor.grayColor().CGColor
        exitButton.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        
        appName = MKLabel()
        appName.text = "Go"
        appName.textColor = UIColor.whiteColor()
        appName.textAlignment = .Center
        appName.font = UIFont.boldSystemFontOfSize(200)
        appName.backgroundLayerColor = UIColor.clearColor()
        
        appName.layer.shadowOpacity = 1
        appName.layer.shadowColor = UIColor.grayColor().CGColor
        appName.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        
        emailField = MKTextField()
        
        emailField.layer.borderColor = UIColor.clearColor().CGColor
        emailField.floatingPlaceholderEnabled = true
        emailField.placeholder = "Email"
        emailField.rippleLayerColor = UIColor.grayColor()
        emailField.tintColor = UIColor.MKColor.Blue
        emailField.backgroundColor = UIColor(hex: 0xEEEEEE)
        emailField.padding = padding
        emailField.layer.cornerRadius = 0
        emailField.bottomBorderEnabled = true
        emailField.bottomBorderHighlightWidth = emailField.bottomBorderWidth
        emailField.tintColor = emailField.bottomBorderColor
        
        passwordField = MKTextField()
        
        passwordField.layer.borderColor = UIColor.clearColor().CGColor
        passwordField.floatingPlaceholderEnabled = true
        passwordField.placeholder = "Password"
        passwordField.rippleLayerColor = UIColor.grayColor()
        passwordField.tintColor = UIColor.MKColor.Blue
        passwordField.backgroundColor = UIColor(hex: 0xEEEEEE)
        passwordField.padding = padding
        passwordField.layer.cornerRadius = 0

        forgotButton = MKButton()
        forgotButton.titleLabel?.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        forgotButton.setTitle("Forgot Password?", forState: .Normal)
        forgotButton.clipsToBounds = true
        forgotButton.backgroundAniEnabled = false
    
        emailLoginButton = SNButton()
        emailLoginButton.network = .Email
        
        facebookLoginButton = SNButton()
        facebookLoginButton.network = .Facebook
        facebookLoginButton.addTarget(self, action: "facebookButtonAction", forControlEvents: .TouchUpInside)
        
        twitterLoginButton = SNButton()
        twitterLoginButton.network = .Twitter
        
        view.addSubview(exitButton)
        view.addSubview(appName)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(forgotButton)
        view.addSubview(emailLoginButton)
        view.addSubview(facebookLoginButton)
        view.addSubview(twitterLoginButton)
    }
    
    // MARK: - Layout
    
    func layoutSubviews() {
        
        let buffer = CGFloat(16)
        let spacing = CGFloat(8)
        
        let btnHeight = CGFloat(50)
        
        let z = CGFloat(0)
        
        exitButton.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        exitButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        exitButton.autoSetDimensionsToSize(CGSize(width: btnHeight, height: btnHeight))
        
        appName.autoPinEdgeToSuperviewEdge(.Left, withInset: buffer)
        appName.autoPinEdgeToSuperviewEdge(.Right, withInset: buffer)

        
        emailField.autoPinEdge(.Top, toEdge: .Bottom, ofView: appName, withOffset: z)
        emailField.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: z)
        emailField.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: z)
        emailField.autoSetDimension(ALDimension.Height, toSize: btnHeight)
        
        passwordField.autoPinEdge(.Top, toEdge: .Bottom, ofView: emailField, withOffset: z)
        passwordField.autoPinEdgeToSuperviewEdge(.Left, withInset: z)
        passwordField.autoPinEdgeToSuperviewEdge(.Right, withInset: z)
        passwordField.autoSetDimension(.Height, toSize: btnHeight)
        
        forgotButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: passwordField, withOffset: spacing)
        forgotButton.autoPinEdgeToSuperviewEdge(.Left, withInset: btnHeight)
        forgotButton.autoPinEdgeToSuperviewEdge(.Right, withInset: btnHeight)
        forgotButton.autoSetDimension(.Height, toSize: btnHeight/2.0)
        
        emailLoginButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: forgotButton, withOffset: spacing)
        emailLoginButton.autoPinEdgeToSuperviewEdge(.Left, withInset: z)
        emailLoginButton.autoPinEdgeToSuperviewEdge(.Right, withInset: z)
        emailLoginButton.autoSetDimension(.Height, toSize: btnHeight)
        
        facebookLoginButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: emailLoginButton, withOffset: spacing)
        facebookLoginButton.autoPinEdgeToSuperviewEdge(.Left, withInset: z)
        facebookLoginButton.autoPinEdgeToSuperviewEdge(.Right, withInset: z)
        facebookLoginButton.autoSetDimension(.Height, toSize: btnHeight)
        
        twitterLoginButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: facebookLoginButton, withOffset: spacing)
        twitterLoginButton.autoPinEdgeToSuperviewEdge(.Left, withInset: z)
        twitterLoginButton.autoPinEdgeToSuperviewEdge(.Right, withInset: z)
        twitterLoginButton.autoPinToBottomLayoutGuideOfViewController(self, withInset: buffer)
        twitterLoginButton.autoSetDimension(.Height, toSize: btnHeight)
    }
}