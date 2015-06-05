//
//  SignUpViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/4/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout

import FBSDKCoreKit
import FBSDKLoginKit

import MaterialKit

class SignUpViewController: UIViewController {
    var appName: MKLabel!

    var nameField: MKTextField!
    var emailField: MKTextField!
    var passwordField: MKTextField!
    var confirmField: MKTextField!
    
    var signupButton: MKButton!
    var facebookLoginButton: SNButton!
    var twitterLoginButton: SNButton!
    
    var exitButton: MKButton!
    
    var orImageView: UIImageView!
    
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
        appName.font = UIFont.boldSystemFontOfSize(50)
        appName.backgroundLayerColor = UIColor.clearColor()
        
        appName.layer.shadowOpacity = 1
        appName.layer.shadowColor = UIColor.grayColor().CGColor
        appName.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        
        nameField = MKTextField()
        
        nameField.layer.borderColor = UIColor.clearColor().CGColor
        nameField.floatingPlaceholderEnabled = true
        nameField.placeholder = "Full Name"
        nameField.rippleLayerColor = UIColor.grayColor()
        nameField.backgroundColor = UIColor(hex: 0xEEEEEE)
        nameField.padding = padding
        nameField.layer.cornerRadius = 0
        nameField.bottomBorderEnabled = true
        nameField.bottomBorderHighlightWidth = nameField.bottomBorderWidth
        nameField.tintColor = nameField.bottomBorderColor
        
        emailField = MKTextField()
        
        emailField.layer.borderColor = UIColor.clearColor().CGColor
        emailField.floatingPlaceholderEnabled = true
        emailField.placeholder = "Email Address"
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
        passwordField.backgroundColor = UIColor(hex: 0xEEEEEE)
        passwordField.padding = padding
        passwordField.layer.cornerRadius = 0
        passwordField.bottomBorderEnabled = true
        passwordField.bottomBorderHighlightWidth = passwordField.bottomBorderWidth
        passwordField.tintColor = passwordField.bottomBorderColor
        passwordField.secureTextEntry = true
        
        confirmField = MKTextField()
        
        confirmField.layer.borderColor = UIColor.clearColor().CGColor
        confirmField.floatingPlaceholderEnabled = true
        confirmField.placeholder = "Confirm Password"
        confirmField.rippleLayerColor = UIColor.grayColor()
        confirmField.backgroundColor = UIColor(hex: 0xEEEEEE)
        confirmField.padding = padding
        confirmField.layer.cornerRadius = 0
        confirmField.bottomBorderEnabled = true
        confirmField.bottomBorderHighlightWidth = confirmField.bottomBorderWidth
        confirmField.tintColor = confirmField.bottomBorderColor
        confirmField.secureTextEntry = true
        
        signupButton = MKButton()
        signupButton.backgroundColor = UIColor.MKColor.Orange
        signupButton.rippleLayerColor = UIColor.grayColor()
        
        signupButton.layer.cornerRadius = 0
        signupButton.layer.shadowOpacity = 0.55
        signupButton.layer.shadowRadius = 0
        signupButton.layer.shadowColor = UIColor.grayColor().CGColor
        signupButton.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        signupButton.setTitle("Sign up", forState: .Normal)
        signupButton.titleLabel!.font = UIFont.boldSystemFontOfSize(25)
        
        orImageView = UIImageView(image: UIImage(named: "OR"))
        orImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        orImageView.layer.cornerRadius = 0
        orImageView.layer.shadowOpacity = 0.55
        orImageView.layer.shadowRadius = 0
        orImageView.layer.shadowColor = UIColor.grayColor().CGColor
        orImageView.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        
        facebookLoginButton = SNButton()
        facebookLoginButton.network = .Facebook
        facebookLoginButton.addTarget(self, action: "facebookButtonAction", forControlEvents: .TouchUpInside)
        
        twitterLoginButton = SNButton()
        twitterLoginButton.network = .Twitter
        
        view.addSubview(exitButton)
        view.addSubview(appName)
        view.addSubview(nameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(confirmField)
        view.addSubview(signupButton)
        view.addSubview(orImageView)
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
        
        appName.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        appName.autoPinEdgeToSuperviewEdge(.Left, withInset: buffer)
        appName.autoPinEdgeToSuperviewEdge(.Right, withInset: buffer)
        
        nameField.autoPinEdge(.Top, toEdge: .Bottom, ofView: appName, withOffset: z)
        nameField.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: z)
        nameField.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: z)
        nameField.autoSetDimension(ALDimension.Height, toSize: btnHeight)
        
        emailField.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameField, withOffset: z)
        emailField.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: z)
        emailField.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: z)
        emailField.autoSetDimension(ALDimension.Height, toSize: btnHeight)
        
        passwordField.autoPinEdge(.Top, toEdge: .Bottom, ofView: emailField, withOffset: z)
        passwordField.autoPinEdgeToSuperviewEdge(.Left, withInset: z)
        passwordField.autoPinEdgeToSuperviewEdge(.Right, withInset: z)
        passwordField.autoSetDimension(.Height, toSize: btnHeight)
        
        confirmField.autoPinEdge(.Top, toEdge: .Bottom, ofView: passwordField, withOffset: z)
        confirmField.autoPinEdgeToSuperviewEdge(.Left, withInset: z)
        confirmField.autoPinEdgeToSuperviewEdge(.Right, withInset: z)
        confirmField.autoSetDimension(.Height, toSize: btnHeight)
        
        signupButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: confirmField, withOffset: spacing)
        signupButton.autoPinEdgeToSuperviewEdge(.Left, withInset: z)
        signupButton.autoPinEdgeToSuperviewEdge(.Right, withInset: z)
        signupButton.autoSetDimension(.Height, toSize: btnHeight)
        
        orImageView.autoPinEdgeToSuperviewEdge(.Left, withInset: z)
        orImageView.autoPinEdgeToSuperviewEdge(.Right, withInset: z)
//        orImageView.autoSetDimension(.Height, toSize: btnHeight/2)
        
        facebookLoginButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: orImageView, withOffset: spacing)
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

