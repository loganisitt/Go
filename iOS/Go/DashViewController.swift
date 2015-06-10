//
//  DashViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/4/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit
import Cent

class DashViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dateScroller: DateScroller!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.hidden = false
        navigationController?.navigationBar.hideHairline()
        navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 177.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(25), NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        navigationController?.toolbar.barTintColor = UIColor(red: 0, green: 177.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        navigationController?.toolbar.tintColor = UIColor.whiteColor()
        navigationController?.toolbar.translucent = false
        
        navigationItem.hidesBackButton = true
        navigationItem.title = "Dash"
        
        let plusImage = UIImage().imageFromText(String.ioniconWithName(.Plus), font: UIFont.ioniconOfSize(25), maxWidth: 1000, color:UIColor.whiteColor());
        
        let createButton = UIBarButtonItem(image: plusImage, style: UIBarButtonItemStyle.Plain, target: self, action: "createButtonAction");
        navigationItem.rightBarButtonItem = createButton
        
        setupViews()
        layoutViews()
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
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.rowHeight = 60
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        
        tableView.tableFooterView = UIView(frame: .zeroRect)
        
        view.addSubview(dateScroller)
        view.addSubview(tableView)
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - TableView Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        return cell
    }
}
