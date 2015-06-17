//
//  SigninViewController.swift
//  Go
//
//  Created by Logan Isitt on 5/4/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout
import MaterialKit

import FBSDKCoreKit
import FBSDKLoginKit

class SigninViewController: UIViewController, ClientDelegate {
    
    var appName: GOLabel!
    
    var emailField: GOTextField!
    var passwordField: GOTextField!
    var forgotButton: MKButton!
    
    var emailLoginButton: SNButton!
    var facebookLoginButton: SNButton!
    var twitterLoginButton: SNButton!
    
    var exitButton: MKButton!
    
    // MARK: - General
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.hidden = true

        view.backgroundColor = UIColor.go_main_color()
        
        Client.sharedInstance.delegate = self
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            // User is already logged in, do work such as go to next view controller.
            Client.sharedInstance.signinWithFacebook(FBSDKAccessToken.currentAccessToken().tokenString)
        }
        
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
    
    func facebookLoginButtonAction() {
        
        let login = FBSDKLoginManager()
        login.logInWithReadPermissions(["email"], handler: { (result :FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
            println("User Logged In")
            
            if ((error) != nil){
                // Process error
            } else if result.isCancelled {
                // Handle cancellations
            } else {
                
                Client.sharedInstance.signinWithFacebook(FBSDKAccessToken.currentAccessToken().tokenString)
                
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                if result.grantedPermissions.contains("email")
                {
                    // Do work
                }
            }
        })
    }
    
    func exitButtonAction() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func resignFirstResponders() {
        
        for v in view.subviews {
            if v.isFirstResponder() {
                v.resignFirstResponder()
            }
        }
    }
    
    // MARK: - Views
    
    func setupViews() {
        
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
        exitButton.layer.shadowColor = UIColor.blackColor().CGColor
        exitButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        appName = GOLabel()
        appName.text = "Go"
        appName.font = UIFont.boldSystemFontOfSize(200)
        
        emailField = GOTextField()
        emailField.placeholder = "Email"
        
        passwordField = GOTextField()
        passwordField.placeholder = "Password"
        
        forgotButton = MKButton()
        forgotButton.titleLabel?.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        forgotButton.setTitle("Forgot Password?", forState: .Normal)
        forgotButton.clipsToBounds = true
        forgotButton.backgroundAniEnabled = false
        
        forgotButton.layer.cornerRadius = 0
        forgotButton.layer.shadowOpacity = 0.55
        forgotButton.layer.shadowRadius = 0
        forgotButton.layer.shadowColor = UIColor.blackColor().CGColor
        forgotButton.layer.shadowOffset = CGSize(width: -0.5, height: 0.5)
        
        emailLoginButton = SNButton()
        emailLoginButton.network = .Email
        
        facebookLoginButton = SNButton()
        facebookLoginButton.network = .Facebook
        facebookLoginButton.addTarget(self, action: "facebookLoginButtonAction", forControlEvents: .TouchUpInside)
        
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
        
        exitButton.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        exitButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        exitButton.autoSetDimensionsToSize(CGSize(width: 50, height: 50))
        
        appName.autoPinEdgeToSuperviewEdge(.Left, withInset: 16)
        appName.autoPinEdgeToSuperviewEdge(.Right, withInset: 16)
        
        emailField.autoPinEdge(.Top, toEdge: .Bottom, ofView: appName, withOffset: 0)
        emailField.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 0)
        emailField.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 0)
        emailField.autoSetDimension(ALDimension.Height, toSize: 50)
        
        passwordField.autoPinEdge(.Top, toEdge: .Bottom, ofView: emailField, withOffset: 0)
        passwordField.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        passwordField.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        passwordField.autoSetDimension(.Height, toSize: 50)
        
        forgotButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: passwordField, withOffset: 8)
        forgotButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 50)
        forgotButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 50)
        forgotButton.autoSetDimension(.Height, toSize: 50/2.0)
        
        emailLoginButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: forgotButton, withOffset: 8)
        emailLoginButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        emailLoginButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        emailLoginButton.autoSetDimension(.Height, toSize: 50)
        
        facebookLoginButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: emailLoginButton, withOffset: 8)
        facebookLoginButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        facebookLoginButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        facebookLoginButton.autoSetDimension(.Height, toSize: 50)
        
        twitterLoginButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: facebookLoginButton, withOffset: 8)
        twitterLoginButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        twitterLoginButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        twitterLoginButton.autoPinToBottomLayoutGuideOfViewController(self, withInset: 16)
        twitterLoginButton.autoSetDimension(.Height, toSize: 50)
    }
    
    // MARK: - ClientDelegate
    
    func signInSuccessful() {
        println("Sign In Successful!")
        performSegueWithIdentifier("gotoDash", sender: self)
    }
    
    func signInFailed() {
        println("Sign In Failed!")
    }
}