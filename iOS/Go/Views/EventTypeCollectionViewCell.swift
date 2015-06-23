//
//  EventTypeCollectionViewCell.swift
//  Go
//
//  Created by Logan Isitt on 6/11/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit
import MaterialKit

class EventTypeCollectionViewCell: UICollectionViewCell {

    var imageView: MKImageView!
    var titleLabel: GOLabel!
    
    override var selected: Bool {
        didSet {
            if selected {
                imageView.tintColor = UIColor.go_yellow()
                titleLabel.textColor = UIColor.go_yellow()
            }
            else {
                imageView.tintColor = UIColor.go_white()
                titleLabel.textColor = UIColor.go_white()
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

        imageView = MKImageView(frame: bounds)
        imageView.contentMode = .ScaleAspectFit
        imageView.tintColor = UIColor.go_white()
        
        imageView.layer.cornerRadius = 0
        imageView.layer.shadowOpacity = 0.55
        imageView.layer.shadowRadius = 0
        imageView.layer.shadowColor = UIColor.go_shadow_color().CGColor
        imageView.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        titleLabel = GOLabel()
        titleLabel.font = UIFont.boldSystemFontOfSize(14)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !CGRectEqualToRect(frame, CGRect.zeroRect) {
            layout()
        }
    }

    func layout() {
        imageView.autoPinEdgesToSuperviewMarginsExcludingEdge(.Bottom)
        
        titleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: imageView)
        titleLabel.autoPinEdgesToSuperviewMarginsExcludingEdge(.Top)
        titleLabel.autoSetDimension(.Height, toSize: bounds.height/4.0)
    }
}
