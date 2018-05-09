//
//  ArcDrawer.swift
//  Rect
//
//  Created by Nikolas Omelianov on 09.05.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit


class ArcLayerDrawer: CustomStringConvertible {

    class func drawCircle(center: CGPoint , radius: CGFloat,start: CGFloat, end : CGFloat) -> CAShapeLayer {
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: start,
                                      endAngle: end,
                                      clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.yellow.cgColor
        shapeLayer.lineWidth = 2.0
        
        return (shapeLayer)
    }
    
    var description: String {
        return "arc shape layer \nlinewidth: 2.0\ncolor: yellow "
    }
}
