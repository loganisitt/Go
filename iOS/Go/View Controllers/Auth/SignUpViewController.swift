//
//  SignUpViewController.swift
//  Go
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout
import MaterialKit

class SignUpViewController: UIViewController {
    
    var appName: GOLabel!
    
    var nameField: GOTextField!
    var emailField: GOTextField!
    var passwordField: GOTextField!
    var confirmField: GOTextField!
    
    var signupButton: SNButton!
    var facebookLoginButton: SNButton!
    var twitterLoginButton: SNButton!
    
    var exitButton: MKButton!
    
    var orImageView: UIImageView!
    
    // MARK: - General
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.hidden = true
        
        view.backgroundColor = UIColor.go_main_color()
        
        setupViews()
        
        layoutViews()
        
        let singleTap = UITapGestureRecognizer(target: self, action: Selector("resignFirstResponders"))
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("resignFirstResponders"))
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(downSwipe)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Actions
    
    func exitButtonAction() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func signupButtonAction() {
        if emailField.hasText() && passwordField.hasText() {
            Client.sharedInstance.signUpWith(emailField.text, password: passwordField.text)
        }
        else {
            println("Empty field(s)")
        }
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
        appName.font = UIFont.boldSystemFontOfSize(50)
        
        nameField = GOTextField()
        nameField.placeholder = "Full Name"
        
        emailField = GOTextField()
        emailField.placeholder = "Email Address"
        
        passwordField = GOTextField()
        passwordField.placeholder = "Password"
        
        confirmField = GOTextField()
        confirmField.placeholder = "Confirm Password"
        
        signupButton = SNButton()
        signupButton.hasIcon = false
        signupButton.setTitle("Sign up", forState: .Normal)
        signupButton.backgroundColor = UIColor.go_orange()
        
        signupButton.addTarget(self, action: "signupButtonAction", forControlEvents: .TouchUpInside)
        
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
    
    func layoutViews() {
        
        exitButton.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        exitButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        exitButton.autoSetDimensionsToSize(CGSize(width: 50, height: 50))
        
        appName.autoAlignAxis(.Horizontal, toSameAxisOfView: exitButton)
        appName.autoPinEdgeToSuperviewEdge(.Left, withInset: 16)
        appName.autoPinEdgeToSuperviewEdge(.Right, withInset: 16)
        
        nameField.autoPinEdge(.Top, toEdge: .Bottom, ofView: appName, withOffset: 8)
        nameField.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 0)
        nameField.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 0)
        nameField.autoSetDimension(ALDimension.Height, toSize: 50)
        
        emailField.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameField, withOffset: 0)
        emailField.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 0)
        emailField.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 0)
        emailField.autoSetDimension(ALDimension.Height, toSize: 50)
        
        passwordField.autoPinEdge(.Top, toEdge: .Bottom, ofView: emailField, withOffset: 0)
        passwordField.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        passwordField.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        passwordField.autoSetDimension(.Height, toSize: 50)
        
        confirmField.autoPinEdge(.Top, toEdge: .Bottom, ofView: passwordField, withOffset: 0)
        confirmField.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        confirmField.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        confirmField.autoSetDimension(.Height, toSize: 50)
        
        signupButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: confirmField, withOffset: 8)
        signupButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        signupButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        signupButton.autoSetDimension(.Height, toSize: 50)
        
        orImageView.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        orImageView.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        
        facebookLoginButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: orImageView, withOffset: 8)
        facebookLoginButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        facebookLoginButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        facebookLoginButton.autoSetDimension(.Height, toSize: 50)
        
        twitterLoginButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: facebookLoginButton, withOffset: 8)
        twitterLoginButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        twitterLoginButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        twitterLoginButton.autoPinToBottomLayoutGuideOfViewController(self, withInset: 16)
        twitterLoginButton.autoSetDimension(.Height, toSize: 50)
    }
}
