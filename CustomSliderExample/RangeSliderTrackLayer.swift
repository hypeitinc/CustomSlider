//
//  RangeSliderTrackLayer.swift
//  CustomSliderExample
//
//  CustomSliderExample from: https://www.raywenderlich.com/76433/how-to-make-a-custom-control-swift
//  Converted to Swift 4 by Peter Rexelius on 4/25/18.
//  Copyright © 2018 HYPEIT INC. Peter Rexelius. All rights reserved.
//

import UIKit
import QuartzCore

// Renders the track that the two thumbs slide on
class RangeSliderTrackLayer: CALayer {
    weak var rangeSlider: RangeSlider?
    
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            // Clip the track shape
            let cornerRadius = bounds.height * slider.curvaceousness / 2.0
            let scaledBounds = CGRect(x: 0, y:0, width: bounds.width, height: bounds.height * slider.trackSizeScale)
            let path = UIBezierPath(roundedRect: scaledBounds, cornerRadius: cornerRadius)
            ctx.addPath(path.cgPath)
            
            // Fill the track
            ctx.setFillColor(slider.trackTintColor.cgColor)
            ctx.addPath(path.cgPath)
            ctx.fillPath()
            
            // Fill the highlighted range
            ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
            let lowerValuePosition = CGFloat(slider.positionForValue(value: slider.lowerValue))
            let upperValuePosition = CGFloat(slider.positionForValue(value: slider.upperValue))
            let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: scaledBounds.height)
            ctx.fill(rect)
        }
    }
    
    
}
