//
//  DashViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/4/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit
import Cent

import ObjectMapper

class DashViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dateScroller: DateScroller!
    var tableView: UITableView!
    
    var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.hidden = false
        
        navigationItem.hidesBackButton = true
        navigationItem.title = "Dash"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.addButton(target: self, selector: "createButtonAction")
        
        setupViews()
        layoutViews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        Client.sharedInstance.allEvents { events, error in
            self.events = events
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Actions 
    
    func createButtonAction() {
        performSegueWithIdentifier("gotoCreate", sender: nil)
    }
    
    // MARK: - Views
    
    func setupViews() {
        
        dateScroller = DateScroller()
        
        // tableView
        tableView = UITableView(frame: .zeroRect, style: .Plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(DashTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.rowHeight = 60
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        
        tableView.tableFooterView = UIView(frame: .zeroRect)
        
        view.addSubview(tableView)
        view.addSubview(dateScroller)
    }
    
    // MARK: - Layout
    
    func layoutViews() {
        
        tableView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        tableView.autoPinEdgeToSuperviewEdge(.Left)
        tableView.autoPinEdgeToSuperviewEdge(.Right)
        
        dateScroller.autoPinEdge(.Top, toEdge: .Bottom, ofView: tableView, withOffset: 0)
        dateScroller.autoPinEdgeToSuperviewEdge(.Left)
        dateScroller.autoPinEdgeToSuperviewEdge(.Right)
        dateScroller.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
        dateScroller.autoSetDimension(.Height, toSize: (view.bounds.width - 20)/7.0)
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        performSegueWithIdentifier("gotoEvent", sender: indexPath)
    }
    
    // MARK: - TableView Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count(events)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: DashTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! DashTableViewCell
        
        let event = events[indexPath.row]
        
        let url = NSURL(string: Client.sharedInstance.baseUrl + event.eventType.imagePath) as NSURL!
        
        cell.imageView!.hnk_setImageFromURL(url, placeholder: UIImage(named: "Logo"), format: nil, failure: { (error: NSError?) -> () in
                println(error)
            }, success: { (image: UIImage) -> () in
                cell.imageView?.image = image
            })
        cell.textLabel?.text = events[indexPath.row].name
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gotoEvent" {
            let vc: EventViewController = segue.destinationViewController as! EventViewController
            vc.event = events[(sender as! NSIndexPath).row]
        }
    }
}
