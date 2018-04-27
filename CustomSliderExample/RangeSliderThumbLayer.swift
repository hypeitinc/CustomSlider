//
//  RangeSliderThumbLayer.swift
//  CustomSliderExample
//
//  CustomSliderExample from: https://www.raywenderlich.com/76433/how-to-make-a-custom-control-swift
//  Converted to Swift 4 by Peter Rexelius on 4/25/18.
//  Copyright © 2018 HYPEIT INC. Peter Rexelius. All rights reserved.
//

import UIKit
import QuartzCore

// This adds two properties: one that indicates whether this thumb is highlighted, and one that is a reference back to the parent range slider. Since the RangeSlider owns the two thumb layers, the back reference is a weak variable to avoid a retain cycle.

class RangeSliderThumbLayer: CALayer {
    var highlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    weak var rangeSlider: RangeSlider?
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            let thumbFrame = bounds.insetBy(dx: 2.0, dy: 2.0)
            let cornerRadius = thumbFrame.height * slider.curvaceousness / 2.0
            let corners = rangeSlider?.thumbType
            
            var thumbPath : UIBezierPath
            
            switch corners! {
            case 0:
                thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)
            case 3:
                let center = CGPoint(x: thumbFrame.width/2, y: thumbFrame.height/2)
                thumbPath = trianglePathWithCenter(center: center, side: bounds.width / 2)
            case 4:
                thumbPath = UIBezierPath(rect: thumbFrame)
            default:
                thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)
            }
            
            // print("Corners: \(corners!) Path: \(thumbPath)")

            
            // Fill - with a subtle shadow
            let shadowColor = UIColor.gray
            ctx.setShadow(offset: CGSize(width: 0.0, height: 1.0), blur: 1.0, color: shadowColor.cgColor)
            ctx.setFillColor(slider.thumbTintColor.cgColor)
            ctx.addPath(thumbPath.cgPath)
            ctx.fillPath()
            
            // Outline
            ctx.setStrokeColor(shadowColor.cgColor)
            ctx.setLineWidth(0.5)
            ctx.addPath(thumbPath.cgPath)
            ctx.strokePath()
            
            if highlighted {
                ctx.setFillColor(UIColor(white: 0.0, alpha: 0.1).cgColor)
                ctx.addPath(thumbPath.cgPath)
                ctx.fillPath()
            }
        }
    }
    
    func trianglePathWithCenter(center: CGPoint, side: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        
        let startX = center.x - side / 2
        let startY = center.y - side / 2
        
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: startX + side, y: startY))
        path.addLine(to: CGPoint(x: startX + side/2, y: startY + side))
        path.close()
        
        return path
    }
    
    
    
}
