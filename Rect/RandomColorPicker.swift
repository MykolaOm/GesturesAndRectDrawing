//
//  RandomColorPicker.swift
//  Rect
//
//  Created by Nikolas Omelianov on 09.05.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

class RandomColorPicker: CustomStringConvertible {
    class func getColor() -> UIColor {
      
        let red = CGFloat(arc4random_uniform(256))/255
        let green = CGFloat(arc4random_uniform(256))/255
        let blue = CGFloat(arc4random_uniform(256))/255
      
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    class func changeColorAnimated(for view: UIView,to color: UIColor, duration: TimeInterval, options: UIViewAnimationOptions) {
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            view.backgroundColor = color
        }, completion: nil)
    }
    var description: String {
        return "Random UIColor with alpha 1.0"
    }
}
