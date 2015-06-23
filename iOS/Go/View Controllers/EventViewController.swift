//
//  EventViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/19/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout

class EventViewController: RGPageViewController, RGPageViewControllerDataSource, RGPageViewControllerDelegate {

    var event: Event!
    
    var titleLabel: GOLabel!
    var dateLabel: GOLabel!
    
    var joinButton: SNButton!
    
    var dateFormatter: NSDateFormatter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Event"
        navigationItem.leftBarButtonItem = UIBarButtonItem.backButton(target: self, selector: "backButtonAction")
        
        navigationController?.navigationBar.hideShadows()
        
        view.backgroundColor = UIColor.go_main_color()
        
        dateFormatter = NSDateFormatter()
        dateFormatter.doesRelativeDateFormatting = true
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        
        delegate = self
        datasource = self
        
//        setupViews()
//        layout()
    }
    
    func setupViews() {
        titleLabel = GOLabel()
        titleLabel.text = event.name
        titleLabel.font = UIFont.boldSystemFontOfSize(20)

        dateLabel = GOLabel()
        dateLabel.text = dateFormatter.stringFromDate(event.date)
        dateLabel.font = UIFont.boldSystemFontOfSize(20)
        
        joinButton = SNButton()
        joinButton.addTarget(self, action: "joinButtonAction", forControlEvents: .TouchUpInside)
        joinButton.hasIcon = false
        joinButton.backgroundColor = UIColor.go_blue()
        
        if contains(event.attendees!, Client.sharedInstance.currentUser) {
            self.joinButton.setTitle("Leave", forState: .Normal)
        }
        else {
            self.joinButton.setTitle("Join", forState: .Normal)
        }
        
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        view.addSubview(joinButton)
    }
    
    func layout() {
        
        titleLabel.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left)
        titleLabel.autoPinEdgeToSuperviewEdge(.Right)
        titleLabel.autoSetDimension(.Height, toSize: 50)
        
        dateLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: 8)
        dateLabel.autoPinEdgeToSuperviewEdge(.Left)
        dateLabel.autoPinEdgeToSuperviewEdge(.Right)
        dateLabel.autoSetDimension(.Height, toSize: 50)
        
        joinButton.autoPinEdgeToSuperviewEdge(.Left)
        joinButton.autoPinEdgeToSuperviewEdge(.Right)
        joinButton.autoPinToBottomLayoutGuideOfViewController(self, withInset: 8)
        joinButton.autoSetDimension(.Height, toSize: 50)
    }
    
    // MARK: - Actions
    func backButtonAction() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func joinButtonAction() {
        
        if event.attendees != nil && contains(event.attendees!, Client.sharedInstance.currentUser) {
            Client.sharedInstance.leaveEvent(event) { event, error in
                
                if let err = error {
                    println("Error: \(err)")
                }
                else {
                    self.event = event
                    self.joinButton.setTitle("Join", forState: .Normal)
                }
            }
        }
        else {
            Client.sharedInstance.joinEvent(event) { event, error in
                
                if let err = error {
                    println("Error: \(err)")
                }
                else {
                    self.event = event
                    self.joinButton.setTitle("Leave", forState: .Normal)
                }
            }
        }
    }
    
    // MARK: - RGPageViewControllerDataSource
    
    func numberOfPagesForViewController(pageViewController: RGPageViewController) -> Int {
        return 3
    }
    
    func tabViewForPageAtIndex(pageViewController: RGPageViewController, index: Int) -> UIView {
        
        let label = GOLabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width / 3.0, height: pageViewController.tabbarHeight))
        
        label.font = UIFont.boldSystemFontOfSize(14)
        
        if index == 0 {
            label.text = detailViewController.title
        }
        else if index == 1 {
            label.text = playersViewController.title
        }
        else {
            label.text = commentsViewController.title
        }
        
        return label
    }
    
    func viewControllerForPageAtIndex(pageViewController: RGPageViewController, index: Int) -> UIViewController? {
        
        if index == 0 {
            return detailViewController
        }
        else if index == 1 {
            return playersViewController
        }
        else {
            return commentsViewController
        }
    }
    
    // MARK: - View Controllers
    
    var detailViewController: DetailViewController {
        if _detailViewController == nil {
            _detailViewController = DetailViewController()
            _detailViewController?.title = "Details"
        }
        return _detailViewController!
    }
    var _detailViewController: DetailViewController? = nil
    
    var playersViewController: PlayersViewController {
        if _playersViewController == nil {
            _playersViewController = PlayersViewController()
            _playersViewController?.title = "Players"
            _playersViewController?.players = event.attendees!
        }
        return _playersViewController!
    }
    var _playersViewController: PlayersViewController? = nil
    
    var commentsViewController: CommentsViewController {
        if _commentsViewController == nil {
            _commentsViewController = CommentsViewController()
            _commentsViewController?.title = "Comments"
        }
        return _commentsViewController!
    }
    var _commentsViewController: CommentsViewController? = nil
}
