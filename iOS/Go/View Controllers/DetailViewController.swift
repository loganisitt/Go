//
//  DetailViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/22/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var titleLabel: GOLabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        layout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        titleLabel = GOLabel()
        titleLabel.font = UIFont.boldSystemFontOfSize(20)
        
        view.addSubview(titleLabel)
    }
    
    func layout() {
        
        titleLabel.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left)
        titleLabel.autoPinEdgeToSuperviewEdge(.Right)
        titleLabel.autoSetDimension(.Height, toSize: 50)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
