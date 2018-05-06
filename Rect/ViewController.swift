//
//  ViewController.swift
//  Rect
//
//  Created by Nikolas Omelianov on 04.05.18.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var tapCount = 0
    private var tapFinishDrow = 0 {
        didSet {
            setNewRect()
        }
    }
    private var rectTopCornerPoint = CGPoint(x: 0, y: 0)
    private var rectBottomCornerPoint = CGPoint(x: 0, y: 0)
    private var layerLast = CALayer()
    private var viewLast : UIView?
    private var isViewForPan = false
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGestures()
    
        
    }
    @objc private func tapOccured(_ tap: UITapGestureRecognizer) {
        
        tapCount += 1
        print ("tap number:", tapCount)
        
        if tapCount == 1 {
            rectTopCornerPoint = tap.location(in: self.view)
            drawCircle(center: rectTopCornerPoint, radius: CGFloat(15.0), viewSpot: self.view)
            print(self.view.subviews.count)
        }
        else {
            rectBottomCornerPoint = tap.location(in: self.view)
            tapCount = 0
            tapFinishDrow += 1
            layerLast.removeFromSuperlayer()
        }
    }
    
    private func setNewRect(){

        let height = rectBottomCornerPoint.y - rectTopCornerPoint.y
        let width = rectBottomCornerPoint.x - rectTopCornerPoint.x
        let size = CGSize(width: width, height: height)
        let h = height < 0 ? height * (-1) : height
        let w = width < 0 ? width * (-1) : width
        //as told in requirements - don't draw small rects
        if h < 100.0  || w < 100.0  {
            tapCount = 0
            print ("too small")
                return
        }
        
        let newRect = TappableRect(frame: CGRect(origin: rectTopCornerPoint, size: size))

        if isViewForPan {
            viewLast = newRect
        }
        view.addSubview(newRect)

    }
    
    @objc private  func panRecog(pan : UIPanGestureRecognizer){
        switch pan.state {
        case .began : rectTopCornerPoint = pan.location(ofTouch: 0, in: self.view)
        
            print("began")
        case .changed :
            rectBottomCornerPoint = pan.location(ofTouch: 0, in: self.view)
            isViewForPan = true
            if  viewLast != nil {
                viewLast?.removeFromSuperview()
            }
            setNewRect()
//            if  viewLast != nil {
//                viewLast?.backgroundColor = (viewLast as! TappableRect).lastColor
//            }
        case .ended :
            print("end")
            isViewForPan = false
            viewLast = nil

        default:
            return
        }

    }
    
   private func setGestures(){
//        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panRecog(pan:))))
         self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panRecog(pan:))))
        let gestTap = UITapGestureRecognizer(target: self, action: #selector(tapOccured(_ :)))
        self.view.addGestureRecognizer(gestTap)
        
    }
    
    @objc private func printVi(){
        print ("yep!!")
    }
    
    
    private func drawCircle(center: CGPoint , radius: CGFloat, viewSpot: UIView){
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2.0
        layerLast = shapeLayer
        viewSpot.layer.addSublayer(shapeLayer)
    }
  
}
