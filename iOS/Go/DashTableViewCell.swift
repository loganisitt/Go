//
//  DashTableViewCell.swift
//  Go
//
//  Created by Logan Isitt on 6/18/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class DashTableViewCell: UITableViewCell {

    var eventImageView: UIImageView!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    // MARK: Setup
    
    func setup() {

        imageView?.frame = CGRect(origin: CGPoint.zeroPoint, size: CGSize(width: bounds.height, height: bounds.height))
        imageView?.contentMode = .ScaleAspectFit
        
//        addSubview(eventImageView)
        
        layout()
    }
    
    func layout() {
        imageView?.autoPinEdgesToSuperviewMarginsExcludingEdge(.Right)
        imageView?.autoMatchDimension(.Width, toDimension: .Height, ofView: imageView)
        println("\(NSStringFromCGRect(imageView!.frame))")
    }
}
