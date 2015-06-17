//
//  DateScroller.swift
//  Go
//
//  Created by Logan Isitt on 6/9/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout
import MaterialKit

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
        
        backgroundColor = UIColor.go_main_color()
        

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


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class DateHeader: UICollectionReusableView {
    
    let shadowOffset = CGSize(width: -1, height: 1)

    var mainLabel: GOLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        
        mainLabel = GOLabel(frame: bounds)
        mainLabel.font = UIFont.boldSystemFontOfSize(14)
        
        mainLabel.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        
        addSubview(mainLabel)
        
        layout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainLabel.frame = bounds
    }
    
    func layout() {
        mainLabel.autoPinEdgeToSuperviewEdge(.Top)
        mainLabel.autoPinEdgeToSuperviewEdge(.Left)
        mainLabel.autoPinEdgeToSuperviewEdge(.Right)
        mainLabel.autoPinEdgeToSuperviewEdge(.Bottom)
    }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class DateCell: UICollectionViewCell {
    
    let shadowOffset = CGSize(width: -1, height: 1)
    
    var mainLabel: GOLabel!
    var topLabel: GOLabel!
    
    override var selected: Bool {
        didSet {
            if selected {
                topLabel.textColor = UIColor.go_yellow()
                mainLabel.textColor = UIColor.go_yellow()
            }
            else {
                topLabel.textColor = UIColor.go_white()
                mainLabel.textColor = UIColor.go_white()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        setupViews()
        layoutViews()
    }
    
    func setupViews() {
                
        mainLabel = GOLabel()
        mainLabel.font = UIFont.boldSystemFontOfSize(26)
        mainLabel.backgroundAniEnabled = false
        
        topLabel = GOLabel()
        topLabel.font = UIFont.boldSystemFontOfSize(12)
        topLabel.backgroundAniEnabled = false
        
        addSubview(mainLabel)
        addSubview(topLabel)
    }
    
    func layoutViews() {
        topLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: 4)
        topLabel.autoPinEdgeToSuperviewEdge(.Left)
        topLabel.autoPinEdgeToSuperviewEdge(.Right)
        
        mainLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: topLabel, withOffset: 2)
        mainLabel.autoPinEdgeToSuperviewEdge(.Left)
        mainLabel.autoPinEdgeToSuperviewEdge(.Right)
        mainLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 8)
    }
}