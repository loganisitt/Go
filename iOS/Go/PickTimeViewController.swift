//
//  PickTimeViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/9/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class PickTimeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var titleLabel: UILabel!
    var dateScroller: DateScroller!
    var tableView: UITableView!
    
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
        
        dateScroller = DateScroller()
        
        tableView = UITableView(frame: .zeroRect, style: .Plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.rowHeight = 60
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        
        tableView.tableFooterView = UIView(frame: .zeroRect)
        
        view.addSubview(titleLabel)
        view.addSubview(dateScroller)
        view.addSubview(tableView)
    }
    
    // MARK: - Layout
    
    func layoutViews() {
        titleLabel.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left)
        titleLabel.autoPinEdgeToSuperviewEdge(.Right)
        titleLabel.autoSetDimension(.Height, toSize: 50)
        
        dateScroller.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: 0)
        dateScroller.autoPinEdgeToSuperviewEdge(.Left)
        dateScroller.autoPinEdgeToSuperviewEdge(.Right)
        dateScroller.autoSetDimension(.Height, toSize: (view.bounds.width - 20)/7.0)
        
        tableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: dateScroller)
        tableView.autoPinEdgeToSuperviewEdge(.Left)
        tableView.autoPinEdgeToSuperviewEdge(.Right)
        tableView.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
    }
    
    // MARK: - TableView Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 24
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        let hour = indexPath.section % 12 == 0 ? 12 : indexPath.section % 12
        let minute = 15 * indexPath.row
        let ampm = indexPath.section > 12 ? "PM" : "AM"
        
        cell.textLabel?.text = NSString(format: "%d:%02d %@", hour, minute, ampm) as String
        cell.textLabel?.textColor = UIColor.blackColor()
        cell.textLabel?.textAlignment = .Center
        
        cell.textLabel?.font = UIFont.boldSystemFontOfSize(18)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
