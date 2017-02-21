//
//  AppManager.swift
//  ViewPager
//
//  Created by pradip gotamay on 2/21/17.
//  Copyright © 2017 Pradip Gotame. All rights reserved.
//

import UIKit

class AppManager: NSObject {
    
    class func addSlideAnimationtoLeft(layer: CALayer) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type     = kCATransitionPush
        transition.subtype  = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        layer.add(transition, forKey: nil)
    }
    
    class func addSlideAnimationtoRight(layer: CALayer) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type     = kCATransitionPush
        transition.subtype  = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        layer.add(transition, forKey: nil)
    }

}
