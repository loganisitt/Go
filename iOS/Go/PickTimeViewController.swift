//
//  PickTimeViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/9/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import MaterialKit

class PickTimeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let shadowOffset = CGSize(width: -1, height: 1)

    var titleLabel: GOLabel!
    var subtitleLabel: GOLabel!
    var dateScroller: DateScroller!
    var tableView: UITableView!
    var datePicker: UIDatePicker!
    
    var date: NSDate!
    var dateFormatter: NSDateFormatter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        
        setupViews()
        layoutViews()
    }
    
    // MARK: - Views
    func setupViews() {
        
        titleLabel = GOLabel()
        titleLabel.text = self.title
        titleLabel.font = UIFont.boldSystemFontOfSize(20)
        
        subtitleLabel = GOLabel()
        subtitleLabel.text = "Choose a time and date"
        subtitleLabel.font = UIFont.boldSystemFontOfSize(12)
        
        dateScroller = DateScroller()
        
        tableView = UITableView(frame: .zeroRect, style: .Plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.rowHeight = 60
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        
        tableView.tableFooterView = UIView(frame: .zeroRect)
        
        tableView.backgroundColor = UIColor.go_main_color()
        tableView.separatorStyle = .None
        
        datePicker = UIDatePicker()
        datePicker.addTarget(self, action: "datePickerValueChanged", forControlEvents: .ValueChanged)
        
        datePicker.minuteInterval = 15

        
//        view.addSubview(dateScroller)
//        view.addSubview(tableView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(datePicker)
    }
    
    // MARK: - Layout
    
    func layoutViews() {
        
        titleLabel.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left)
        titleLabel.autoPinEdgeToSuperviewEdge(.Right)
        titleLabel.autoSetDimension(.Height, toSize: 50)
        
        subtitleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: -8)
        subtitleLabel.autoPinEdgeToSuperviewEdge(.Left)
        subtitleLabel.autoPinEdgeToSuperviewEdge(.Right)
        subtitleLabel.autoSetDimension(.Height, toSize: 20)
        
        datePicker.autoPinEdge(.Top, toEdge: .Bottom, ofView: subtitleLabel)
        datePicker.autoPinEdgeToSuperviewEdge(.Left)
        datePicker.autoPinEdgeToSuperviewEdge(.Right)
        
//        dateScroller.autoPinEdge(.Top, toEdge: .Bottom, ofView: subtitleLabel, withOffset: 0)
//        dateScroller.autoPinEdgeToSuperviewEdge(.Left)
//        dateScroller.autoPinEdgeToSuperviewEdge(.Right)
//        dateScroller.autoSetDimension(.Height, toSize: (view.bounds.width - 20)/7.0)
//        
//        tableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: dateScroller)
//        tableView.autoPinEdgeToSuperviewEdge(.Left)
//        tableView.autoPinEdgeToSuperviewEdge(.Right)
//        tableView.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
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
        cell.textLabel?.textColor = UIColor.go_white()
        cell.textLabel?.textAlignment = .Center
        
        cell.textLabel?.font = UIFont.boldSystemFontOfSize(24)
        
        cell.textLabel?.layer.cornerRadius = 0
        cell.textLabel?.layer.shadowOpacity = 0.55
        cell.textLabel?.layer.shadowRadius = 0
        cell.textLabel?.layer.shadowColor = UIColor.go_shadow_color().CGColor
        cell.textLabel?.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - UIDatePicker Action
    
    func datePickerValueChanged() {
        date = datePicker.date
        subtitleLabel.text = dateFormatter.stringFromDate(datePicker.date)
    }
}
