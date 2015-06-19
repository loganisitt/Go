//
//  CreateViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/5/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout
import MaterialKit

import GooglePlacesAutocomplete

class CreateViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pageViewController: UIPageViewController!
    var progressView: UIProgressView!
    
    var pageTitles = ["Event", "Location", "Time", "Additional Options"]
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create"
    
        navigationItem.rightBarButtonItem = UIBarButtonItem.saveButton(target: self, selector: "doneButtonAction")
        navigationItem.leftBarButtonItem = UIBarButtonItem.backButton(target: self, selector: "backButtonAction")
        
        addPageViewController()
        addProgressView()
        layout()
    }
    
    // MARK: - Views
    
    func addPageViewController() {
        
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.delegate = self
        pageViewController!.dataSource = self
        pageViewController.view.backgroundColor = UIColor.go_main_color()
        
        let startingViewController: UIViewController = viewControllerAtIndex(0)!
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })
        
        addChildViewController(self.pageViewController!)
        view.addSubview(self.pageViewController!.view)
        
        pageViewController!.didMoveToParentViewController(self)
        
        view.gestureRecognizers = self.pageViewController!.gestureRecognizers
        
        UIPageControl.appearance().backgroundColor = UIColor(red: 0, green: 177.0/255.0, blue: 106.0/255.0, alpha: 1.0)
    }
    
    func addProgressView() {
        
        progressView = UIProgressView()
        progressView.layer.cornerRadius = 0
        progressView.progressViewStyle = UIProgressViewStyle.Bar
        progressView.progress = 0.5
        
        view.addSubview(progressView)
    }
    
    // MARK: - Layout 
    func layout() {
        
        progressView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        progressView.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        progressView.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        progressView.autoSetDimension(.Height, toSize: 5)
        
        pageViewController!.view.autoPinEdge(.Top, toEdge: .Bottom, ofView: progressView)
        pageViewController!.view.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        pageViewController!.view.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        pageViewController!.view.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
    }
    
    // MARK: - Actions
    
    func doneButtonAction() {
        
        if let eventType = pickEventViewController.eventType {
            if let place = pickLocationViewController.place {
                
                if let date = pickTimeViewController.date {
                    
                    let eventName = pickSettingsViewController.eventTitle.hasText() ? pickSettingsViewController.eventTitle.text : "\(eventType.name) Game"
                    
                    let adminId = Client.sharedInstance.currentUser.id
                    
                    let privacy = pickSettingsViewController.privacySwitch.isOff
                    let restrict = pickSettingsViewController.ageSwitch.isOff
                    
                    let minAge = pickSettingsViewController.ageSlider.minValue
                    let maxAge = pickSettingsViewController.ageSlider.maxValue
                    
                    place.getDetails { details in
                        
                        var parameters =
                        ["name": eventName,
                            "admin": adminId,
                            "privacy": privacy,
                            "type": eventType.id,
                            "location": place.description,
                            "longitude": details.longitude,
                            "latitude": details.latitude,
                            "date": date,
                            "maxAttendees": eventType.numOfPlayers,
                            "restrictions": restrict,
                            "minAge": minAge,
                            "maxAge": maxAge]
                        
                        Client.sharedInstance.createEvent(parameters) { error in
                            if error != nil {
                                println("Error: \(error)")
                            }
                            else {
                                self.navigationController?.popViewControllerAnimated(true)
                            }
                        }
                    }
                }
                else {
                    println("Error: No Date defined")
                }
            }
            else {
                println("Error: No Place defined")
            }
        }
        else {
            println("Error: No Event Type defined")
        }
    }
    
    func backButtonAction() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Helpers
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        // Return the data view controller for the given index.
        if (count(pageTitles) == 0) || (index >= count(pageTitles)) {
            return nil
        }
                
        if index == 0 {
            return pickEventViewController
        }
        else if index == 1 {
            return pickLocationViewController
        }
        else if index == 2 {
            return pickTimeViewController
        }
        else { // Settings
            if pickEventViewController.eventType != nil {
                pickSettingsViewController.eventType = pickEventViewController.eventType
            }
            return pickSettingsViewController
        }
    }
    
    func indexOfViewController(viewController: UIViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        if let dataObject: AnyObject = viewController.title {
            return (pageTitles as NSArray).indexOfObject(dataObject)
        } else {
            return NSNotFound
        }
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        index = self.indexOfViewController(viewController as UIViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index = index - 1
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        index = self.indexOfViewController(viewController as UIViewController)
        if index == NSNotFound {
            return nil
        }
        
        index = index + 1
        if index == count(pageTitles) {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return index
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return count(pageTitles)
    }
    
    // MARK: - UIPageViewControllerDelegate
    
    func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        if (orientation == .Portrait) || (orientation == .PortraitUpsideDown) || (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
            // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
            let currentViewController = pageViewController.viewControllers[0] as! UIViewController
            let viewControllers = [currentViewController]
            pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
            
            pageViewController.doubleSided = false
            return .Min
        }
        
        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
        let currentViewController = pageViewController.viewControllers[0] as! DataViewController
        var viewControllers: [AnyObject]
        
        let indexOfCurrentViewController = indexOfViewController(currentViewController)
        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
            let nextViewController = self.pageViewController(pageViewController, viewControllerAfterViewController: currentViewController)
            viewControllers = [currentViewController, nextViewController!]
        } else {
            let previousViewController = self.pageViewController(pageViewController, viewControllerBeforeViewController: currentViewController)
            viewControllers = [previousViewController!, currentViewController]
        }
        pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
        
        return .Mid
    }
    
    // MARK: - View Controllers
    
    var pickEventViewController: PickEventViewController {
        if _pickEventViewController == nil {
            _pickEventViewController = PickEventViewController()
            _pickEventViewController?.title = "Event"
        }
        return _pickEventViewController!
    }
    var _pickEventViewController: PickEventViewController? = nil
    
    var pickLocationViewController: PickLocationViewController {
        if _pickLocationViewController == nil {
            _pickLocationViewController = PickLocationViewController()
            _pickLocationViewController?.title = "Location"
        }
        return _pickLocationViewController!
    }
    var _pickLocationViewController: PickLocationViewController? = nil
    
    var pickTimeViewController: PickTimeViewController {
        if _pickTimeViewController == nil {
            _pickTimeViewController = PickTimeViewController()
            _pickTimeViewController?.title = "Time"
        }
        return _pickTimeViewController!
    }
    var _pickTimeViewController: PickTimeViewController? = nil
    
    var pickSettingsViewController: PickSettingsViewController {
        if _pickSettingsViewController == nil {
            _pickSettingsViewController = PickSettingsViewController()
            _pickSettingsViewController?.title = pageTitles[3]
        }
        return _pickSettingsViewController!
    }
    var _pickSettingsViewController: PickSettingsViewController? = nil
}
