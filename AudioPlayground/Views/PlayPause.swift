//
//  PlayPause.swift
//  AudioPlayground
//
//  Created by JTRACY9 on 5/3/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit

@IBDesignable
class PlayPause: UIView, UIGestureRecognizerDelegate {

    @IBInspectable var color = UIColor.darkGray
    
    var play = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let tap = UITapGestureRecognizer(target: self, action: #selector(togglePlayPause))
        tap.delegate = self
        self.addGestureRecognizer(tap)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(togglePlayPause)))
    }
    
    @objc func togglePlayPause() {
        play = !play
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        var path: UIBezierPath?
        if play {
            path = drawPause()
        } else {
            path = drawPlay()
        }
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        path?.fill()
    }

    func drawPlay() -> UIBezierPath {
        let path = UIBezierPath()
        let topLeft = CGPoint(x: 0, y: 0)
        let bottom = CGPoint(x: 0, y: self.bounds.maxY)
        let rightMid = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY / 2)
        path.move(to: topLeft)
        path.addLine(to: rightMid)
        path.addLine(to: bottom)
        path.close()
        return path
    }
    
    func drawPause() -> UIBezierPath {
        let path = UIBezierPath()
        let margin: CGFloat = 0.15
        let width: CGFloat = 0.25
        
        //Draw Left
        let leftTopLeft = CGPoint(x: self.bounds.maxX * margin, y: 0)
        let leftTopRight = CGPoint(x: self.bounds.maxX * width + leftTopLeft.x, y: 0)
        let leftBotLeft = CGPoint(x: leftTopLeft.x, y: self.bounds.maxY)
        let leftBotRight = CGPoint(x: leftTopRight.x, y: self.bounds.maxY)
        path.move(to: leftTopLeft)
        path.addLine(to: leftTopRight)
        path.addLine(to: leftBotRight)
        path.addLine(to: leftBotLeft)
        path.close()
        
        //Draw Right
        let rightTopLeft = CGPoint(x: self.bounds.maxX - leftTopLeft.x - self.bounds.maxX * width, y: 0)
        let rightTopRight = CGPoint(x: self.bounds.maxX - leftTopLeft.x, y: 0)
        let rightBotLeft = CGPoint(x: rightTopLeft.x, y: self.bounds.maxY)
        let rightBotRight = CGPoint(x: rightTopRight.x, y: self.bounds.maxY)
        path.move(to: rightTopLeft)
        path.addLine(to: rightTopRight)
        path.addLine(to: rightBotRight)
        path.addLine(to: rightBotLeft)
        path.close()
        
        return path
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
