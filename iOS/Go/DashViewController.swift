//
//  DashViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/4/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit
import Cent

class DashViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
UITableViewDelegate, UITableViewDataSource {
    
    var collectionView: UICollectionView!
    var tableView: UITableView!
    
    var dateFormatter: NSDateFormatter!
    
    var secCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.hidden = false
        navigationController?.navigationBar.hideHairline()
        navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 177.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(25), NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        navigationItem.hidesBackButton = true
        navigationItem.title = "Dash"
        
        dateFormatter = NSDateFormatter()
        
        setupViews()
        layoutViews()
    }
    
    // MARK: - Views
    
    func setupViews() {
        
        // collectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        
        collectionView = UICollectionView(frame: CGRect.zeroRect, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerClass(DateCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.registerClass(DateHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        
        collectionView.pagingEnabled = true
        
        collectionView.backgroundColor = UIColor(red: 0, green: 177.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        
        // tableView
        tableView = UITableView(frame: .zeroRect, style: .Plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.rowHeight = 60
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        
        tableView.tableFooterView = UIView(frame: .zeroRect)
        
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    // MARK: - Layout
    
    func layoutViews() {
        
        tableView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        tableView.autoPinEdgeToSuperviewEdge(.Left)
        tableView.autoPinEdgeToSuperviewEdge(.Right)
        
        collectionView.autoPinEdge(.Top, toEdge: .Bottom, ofView: tableView, withOffset: 0)
        collectionView.autoPinEdgeToSuperviewEdge(.Left)
        collectionView.autoPinEdgeToSuperviewEdge(.Right)
        collectionView.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
        collectionView.autoSetDimension(.Height, toSize: view.bounds.width/7.0)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {

        dateFormatter.dateFormat = "MMM"
        if dateFormatter.stringFromDate(14.days.fromNow!) != dateFormatter.stringFromDate(NSDate()) {
            return 2
        }
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dateFormatter.stringFromDate(14.days.fromNow!) != dateFormatter.stringFromDate(NSDate()) {
            secCount = 0
            while (dateFormatter.stringFromDate(secCount.days.fromNow!) == dateFormatter.stringFromDate(NSDate())) {
                secCount++
            }
            return section == 0 ? secCount : 14 - secCount
        }
        secCount = 14
        return 14
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: DateCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! DateCell
        
        let diff = indexPath.section == 0 ? indexPath.row : secCount + indexPath.row
        let date =  diff.days.fromNow
        dateFormatter.dateFormat = "EEE"
        cell.topLabel.text = dateFormatter.stringFromDate(date!)
        dateFormatter.dateFormat = "d"
        cell.mainLabel.text = dateFormatter.stringFromDate(date!)

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var reusableView: UICollectionReusableView = UICollectionReusableView()
        
        if (kind == UICollectionElementKindSectionHeader) {
                    
            var headerView: DateHeader = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", forIndexPath: indexPath) as! DateHeader

            let date =  indexPath.section.months.fromNow
            dateFormatter.dateFormat = "MMM"
            headerView.mainLabel.text = dateFormatter.stringFromDate(date!)
            reusableView = headerView;
        }
        return reusableView
    }
    
    // MARK: - UICollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var cell: DateCell = collectionView.cellForItemAtIndexPath(indexPath) as! DateCell
        cell.backgroundColor = UIColor.MKColor.LightGreen
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        var cell: DateCell = collectionView.cellForItemAtIndexPath(indexPath) as! DateCell
        cell.backgroundColor = UIColor.clearColor()
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let height = collectionView.bounds.height
        return CGSizeMake(height, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 20, height: collectionView.bounds.height)
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeZero
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
