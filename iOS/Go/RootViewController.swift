//
//  RootViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/3/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout
import MaterialKit

class RootViewController: UIViewController, UIPageViewControllerDelegate {

    var pageViewController: UIPageViewController?
    var loginButton: MKButton!
    var signUpButton: MKButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 177.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.hidden = true

        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController!.delegate = self

        let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })

        self.pageViewController!.dataSource = self.modelController

        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)

        self.pageViewController!.didMoveToParentViewController(self)

        self.view.gestureRecognizers = self.pageViewController!.gestureRecognizers
        
        setupSubviews()
        
        layoutSubviews()
    }
    
    // MARK: - Views
    
    func setupSubviews() {
        
        loginButton = MKButton()
        loginButton.backgroundColor = UIColor.MKColor.Red
        loginButton.rippleLayerColor = UIColor.grayColor()
        
        loginButton.layer.cornerRadius = 0
        loginButton.layer.shadowOpacity = 0.55
        loginButton.layer.shadowRadius = 0
        loginButton.layer.shadowColor = UIColor.grayColor().CGColor
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        loginButton.setTitle("Login", forState: .Normal)
        loginButton.titleLabel!.font = UIFont.boldSystemFontOfSize(25)
        
        loginButton.addTarget(self, action: "loginButtonAction", forControlEvents: .TouchUpInside)
        
        view.addSubview(loginButton)
        
        signUpButton = MKButton()
        signUpButton.backgroundColor = UIColor.MKColor.Orange
        signUpButton.rippleLayerColor = UIColor.grayColor()
        
        signUpButton.layer.cornerRadius = 0
        signUpButton.layer.shadowOpacity = 0.55
        signUpButton.layer.shadowRadius = 0
        signUpButton.layer.shadowColor = UIColor.grayColor().CGColor
        signUpButton.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        signUpButton.setTitle("Sign up", forState: .Normal)
        signUpButton.titleLabel!.font = UIFont.boldSystemFontOfSize(25)

        signUpButton.addTarget(self, action: "signupButtonAction", forControlEvents: .TouchUpInside)
        
        view.addSubview(signUpButton)
    }
    
    // MARK: - Layout
    
    func layoutSubviews() {
        let buffer = CGFloat(16)
        let spacing = CGFloat(8)
        
        let btnHeight = CGFloat(50)
                
        pageViewController!.view.autoPinToTopLayoutGuideOfViewController(self, withInset: buffer)
        pageViewController!.view.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        pageViewController!.view.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)

        loginButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: pageViewController!.view, withOffset: spacing)
        loginButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        loginButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        loginButton.autoSetDimension(.Height, toSize: btnHeight)
        
        signUpButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: loginButton, withOffset: spacing)
        signUpButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        signUpButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        signUpButton.autoPinToBottomLayoutGuideOfViewController(self, withInset: buffer)
        signUpButton.autoSetDimension(.Height, toSize: btnHeight)
    }
    
    // MARK: - Actions
    func loginButtonAction() {
        performSegueWithIdentifier("gotoSignin", sender: self)
    }
    
    func signupButtonAction() {
        performSegueWithIdentifier("gotoSignup", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var modelController: ModelController {
        // Return the model controller object, creating it if necessary.
        // In more complex implementations, the model controller may be passed to the view controller.
        if _modelController == nil {
            _modelController = ModelController()
        }
        return _modelController!
    }

    var _modelController: ModelController? = nil

    // MARK: - UIPageViewController delegate methods

    func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        if (orientation == .Portrait) || (orientation == .PortraitUpsideDown) || (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
            // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
            let currentViewController = self.pageViewController!.viewControllers[0] as! UIViewController
            let viewControllers = [currentViewController]
            self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })

            self.pageViewController!.doubleSided = false
            return .Min
        }

        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
        let currentViewController = self.pageViewController!.viewControllers[0] as! DataViewController
        var viewControllers: [AnyObject]

        let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
            let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfterViewController: currentViewController)
            viewControllers = [currentViewController, nextViewController!]
        } else {
            let previousViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerBeforeViewController: currentViewController)
            viewControllers = [previousViewController!, currentViewController]
        }
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })

        return .Mid
    }
}