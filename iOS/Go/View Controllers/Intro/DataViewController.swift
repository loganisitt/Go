//
//  DataViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/3/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout
import MaterialKit

class DataViewController: UIViewController {
    
    let shadowOffset = CGSize(width: -2, height: 2)
    
    var featureLabel: GOLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        featureLabel = GOLabel()
        featureLabel.text = title
        featureLabel.font = UIFont.boldSystemFontOfSize(50)
        
        view.addSubview(featureLabel)
        
        featureLabel.autoPinEdgesToSuperviewMargins()
        
        view.backgroundColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
}