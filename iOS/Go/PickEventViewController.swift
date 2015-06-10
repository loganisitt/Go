//
//  PickEventViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/9/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class PickEventViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var titleLabel: UILabel!
    var collectionView: UICollectionView!
    
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
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        
        collectionView = UICollectionView(frame: CGRect.zeroRect, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
                
        collectionView.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    // MARK: - Layout
    
    func layoutViews() {
        titleLabel.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left)
        titleLabel.autoPinEdgeToSuperviewEdge(.Right)
        titleLabel.autoSetDimension(.Height, toSize: 50)
        
        collectionView.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel)
        collectionView.autoPinEdgeToSuperviewEdge(.Left)
        collectionView.autoPinEdgeToSuperviewEdge(.Right)
        collectionView.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        cell.backgroundColor = UIColor().randomColor()
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let dim = CGFloat(collectionView.bounds.width / 4.0)
        return CGSizeMake(dim, dim)
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
        
        return CGSizeZero
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeZero
    }
}
