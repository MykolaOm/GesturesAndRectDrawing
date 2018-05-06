//
//  TappableRect.swift
//  Rect
//
//  Created by Nikolas Omelianov on 05.05.18.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit

class TappableRect: UIView {

    private var spots = [CGPoint]()
    private var state = 1
    private var numberOfTouches = 0
    private var activeSpots = [Int]()
    private var spotsFlag = 0
    private let areaToCatchTapInRect : CGFloat = 35.0
    /* keys for resizing */
    private let widthKeys = [12,21,34,43]
    private let heightKeys = [14,41,23,32]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .blue
//                randomColor()
        setGestures()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touchArray = [CGPoint]()
        if spots.count > 0 {
            touchArray.append((touches.first?.location(in: self))!)
            if distance(touchArray, spots) {
                state = 1
            }
            else {
                state = 0
            }
        }
    }
    
    // MARK: GESTURES SETTINGS
    
    @objc private func doubleTapped() {
        self.removeFromSuperview()
    }
    
    @objc private func changeColor(pan:UILongPressGestureRecognizer ) {
            pan.minimumPressDuration = 1.5
            self.backgroundColor = randomColor()
    }
    @objc private func panRecog(pan : UIPanGestureRecognizer){
            if pan.state == .began || pan.state == .changed {
                let translation = pan.translation(in: pan.view)
                let posX = (self.center.x) + translation.x
                let posY = (self.center.y) + translation.y
/*  after rotation occured inversed translation
    1  0  0  1      normal
    0 -1  1  0    turn left on 90
   -1  0  0  1    turn left on 90
    0  1  1  0    turn left on 90
*/
                self.center = CGPoint(x: posX, y: posY)
                pan.setTranslation(CGPoint.zero, in: pan.view)
            }
    }
    
    @objc private func singleTap(_ tap :UITapGestureRecognizer){
        superview?.bringSubview(toFront: (tap.view)!)
        if spotsFlag == 0 { createSpots() }
        else { removeSpots() }
            
    }
    
    @objc private func pinchScale(byReactingTo pinchRecognizer: UIPinchGestureRecognizer){
        var touchArray = [pinchRecognizer.location(ofTouch: 0, in: self)]
        if pinchRecognizer.numberOfTouches == 2 {
            touchArray.append(pinchRecognizer.location(ofTouch: 1, in: self))
        }
        if distance(touchArray, spots) {
            if pinchRecognizer.state == .began || pinchRecognizer.state == .changed {
                var scaleX : CGFloat = 1.0
                var scaleY : CGFloat = 1.0
                if activeSpots.count == 2 {
                    let positionCode = activeSpots[0] * 10 + activeSpots[1]

                    if  widthKeys.contains(positionCode) {
                        scaleX = pinchRecognizer.scale
                    } else if heightKeys.contains(positionCode) {
                        scaleY = pinchRecognizer.scale
                    } else{
                        scaleX = pinchRecognizer.scale
                        scaleY = pinchRecognizer.scale
                    }
                }
                self.transform = (self.transform.scaledBy(x: scaleX, y: scaleY))
                pinchRecognizer.scale = 1.0
            }
        }
    }
    @objc private func rotation(gestureRecognizer : UIRotationGestureRecognizer){
        if state == 1, activeSpots.contains(5) {
            if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
                self.transform = self.transform.rotated(by: gestureRecognizer.rotation)
                gestureRecognizer.rotation = 0
            }
        }
    }
    // MARK: VIEW COLOR

    
    private func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(256))/255
        let green = CGFloat(arc4random_uniform(256))/255
        let blue = CGFloat(arc4random_uniform(256))/255
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    // MARK: SPOTS

   
    /* function aproves if touch on spot area inside rect */
    private func distance(_ a: [CGPoint], _ b: [CGPoint]) -> Bool {
        activeSpots.removeAll()
        var result = false
        var distanceCounter = 0
        var index = 0
        var dist : CGFloat = 0.0
            for ap in a {
                index = 0
                for bp in b {
                    index += 1
                    let xDist = ap.x - bp.x
                    let yDist = ap.y - bp.y
                    dist = CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
                    if dist <= areaToCatchTapInRect && dist >= 0 {
                        activeSpots.append(index)
                        distanceCounter += 1
                        if distanceCounter == a.count {
                            result = true
                        }
                    }
                }
            }
        return result
    }
    private func removeSpots(){
        spotsFlag = 0
        self.layer.sublayers?.removeAll()
    }
    
    private func createSpots() {
        spotsFlag = 1
        let radius :CGFloat = 10.0
        let minX = self.bounds.minX
        let minY = self.bounds.minY
        let maxX = self.bounds.maxX
        let maxY = self.bounds.maxY
        let topLineX = self.frame.width / 2
        
        spots.append(CGPoint(x: minX, y: minY))
        spots.append(CGPoint(x: maxX, y: minY))
        spots.append(CGPoint(x: maxX, y: maxY))
        spots.append(CGPoint(x: minX, y: maxY))
        spots.append(CGPoint(x: topLineX, y: minY))

        /*  it is a numbers ,not an indexes.
         1 - (5)- > 2
         ^          |
         |          v
         4 < - - -  3
        */
        
        for spot in spots{
            drawCircle(center: spot, radius: radius)
        }
    }
    
      private func drawCircle(center: CGPoint , radius: CGFloat){
            let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = UIColor.yellow.cgColor
            shapeLayer.lineWidth = 2.0

            self.layer.addSublayer(shapeLayer)
    }
    
    // MARK: INITIAL SET

   private func setGestures(){
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(singleTap)))
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panRecog)))
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(changeColor)))
        self.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(pinchScale)))
        self.addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(rotation)))
    }
}
