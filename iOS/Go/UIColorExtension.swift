//
//  UIColor+UIColorExtension.swift
//  Go
//
//  Created by Logan Isitt on 6/9/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

extension UIColor {
    
    func randomColor() -> UIColor {
        
        var randomRed:CGFloat = CGFloat(drand48())
        
        var randomGreen:CGFloat = CGFloat(drand48())
        
        var randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
