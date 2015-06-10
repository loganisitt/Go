//
//  DateScroller.swift
//  Go
//
//  Created by Logan Isitt on 6/9/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class DateScroller: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var dateFormatter: NSDateFormatter!
    var secCount = 0
    
    // MARK: - Initialization
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {

        let newLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        newLayout.scrollDirection = .Horizontal
        
        super.init(frame: frame, collectionViewLayout: newLayout)
        
        setup()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    // MARK: - Setup
    
    func setup() {
        
        delegate = self
        dataSource = self
        
        registerClass(DateCell.self, forCellWithReuseIdentifier: "Cell")
        registerClass(DateHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        
        backgroundColor = UIColor(red: 0, green: 177.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        
        dateFormatter = NSDateFormatter()
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
}