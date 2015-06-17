//
//  PickLocationViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/9/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout

import GooglePlacesAutocomplete

import MaterialKit

class PickLocationViewController: UIViewController, GooglePlacesAutocompleteDelegate {
    
//    let shadowOffset = CGSize(width: -1, height: 1)

    var titleLabel: GOLabel!
    var subtitleLabel: GOLabel!
    var gpAutocomplete: GooglePlacesAutocomplete!
    
    var place: Place! {
        didSet {
            if place != nil {
                subtitleLabel.text = place.description   
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gpAutocomplete = GooglePlacesAutocomplete(apiKey: "AIzaSyA4tDpdwIJoQDEFNB_85wpb-BhGT0_3Zjk", placeType: .All)
        gpAutocomplete.placeDelegate = self
        
        addChildViewController(self.gpAutocomplete.gpaViewController)
        view.addSubview(self.gpAutocomplete!.gpaViewController.view)
        
        gpAutocomplete!.gpaViewController.didMoveToParentViewController(self)
        
        setupViews()
        layoutViews()
    }
    
    // MARK: - Views
    func setupViews() {
        
        titleLabel = GOLabel()
        titleLabel.text = self.title
        titleLabel.font = UIFont.boldSystemFontOfSize(20)
        
        subtitleLabel = GOLabel()
        subtitleLabel.text = "Location address or name"
        subtitleLabel.font = UIFont.boldSystemFontOfSize(12)

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
    }
    
    // MARK: - Layout
    
    func layoutViews() {
        titleLabel.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left)
        titleLabel.autoPinEdgeToSuperviewEdge(.Right)
        titleLabel.autoSetDimension(.Height, toSize: 50)
        
        subtitleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: -8)
        subtitleLabel.autoPinEdgeToSuperviewEdge(.Left)
        subtitleLabel.autoPinEdgeToSuperviewEdge(.Right)
        subtitleLabel.autoSetDimension(.Height, toSize: 20)
        
        gpAutocomplete!.gpaViewController.view.autoPinEdge(.Top, toEdge: .Bottom, ofView: subtitleLabel)
        gpAutocomplete!.gpaViewController.view.autoPinEdgeToSuperviewEdge(.Left)
        gpAutocomplete!.gpaViewController.view.autoPinEdgeToSuperviewEdge(.Right)
        gpAutocomplete!.gpaViewController.view.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
    }
    
    // MARK: - GooglePlacesAutocompleteDelegate
    func placesFound(places: [Place]) {
        
    }
    
    func placeSelected(place: Place) {
        self.place = place
    }
    
    func placeViewClosed() {
        
    }
}
