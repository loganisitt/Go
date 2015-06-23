//
//  PickEventViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/9/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import Haneke

import MaterialKit

class PickEventViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var titleLabel: GOLabel!
    var collectionView: UICollectionView!
    
    var eventTypes: [EventType] = []
    var eventType: EventType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        layoutViews()
        
        Client.sharedInstance.getAllEventTypes({ (eventTypes, error) -> () in
            self.eventTypes = eventTypes
            self.collectionView.reloadData()
        })
    }
    
    // MARK: - Views
    func setupViews() {
        
        titleLabel = GOLabel()
        titleLabel.text = self.title
        titleLabel.font = UIFont.boldSystemFontOfSize(20)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        
        collectionView = UICollectionView(frame: CGRect.zeroRect, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerClass(EventTypeCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
                
        collectionView.backgroundColor = UIColor.go_main_color()
        
        view.addSubview(collectionView)
        view.addSubview(titleLabel)
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
        return count(eventTypes)
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: EventTypeCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! EventTypeCollectionViewCell
        
        cell.titleLabel.text = eventTypes[indexPath.row].name
        
        let url: NSURL = NSURL(string: Client.sharedInstance.baseUrl + eventTypes[indexPath.row].imagePath)!
        
        cell.imageView.hnk_setImageFromURL(url, placeholder: UIImage(named: "Logo"), format: nil, failure: { (error: NSError?) -> () in
            println("Error: \(error)")
        }, success: { (image: UIImage) -> () in
            cell.imageView.image = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        })
                
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        eventType = eventTypes[indexPath.row]
    }
    
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
