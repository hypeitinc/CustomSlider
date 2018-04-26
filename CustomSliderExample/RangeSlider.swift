//
//  RangeSlider.swift
//  CustomSliderExample
//
//  CustomSliderExample from: https://www.raywenderlich.com/76433/how-to-make-a-custom-control-swift
//  Converted to Swift 4 by Peter Rexelius on 4/25/18.
//  Copyright © 2018 HYPEIT INC. Peter Rexelius. All rights reserved.
//


import UIKit
import QuartzCore

class RangeSlider: UIControl {
    var minimumValue = 0.0
    var maximumValue = 1.0
    var lowerValue = 0.2                // user input result
    var upperValue = 0.8                // user input result
    var previousLocation = CGPoint()    // track the touch locations
    
    // These three layers — trackLayer, lowerThumbLayer, and upperThumbLayer — will be used to render the various components of your slider control. thumbWidth will be used for layout purposes.
    let trackLayer = CALayer()
    let lowerThumbLayer = RangeSliderThumbLayer()
    let upperThumbLayer = RangeSliderThumbLayer()
    
    var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Create three layers and add them as children of the control’s root layer,
        trackLayer.backgroundColor = UIColor.blue.cgColor
        layer.addSublayer(trackLayer)
        
        lowerThumbLayer.backgroundColor = UIColor.green.cgColor
        layer.addSublayer(lowerThumbLayer)
        
        upperThumbLayer.backgroundColor = UIColor.green.cgColor
        layer.addSublayer(upperThumbLayer)
        
        updateLayerFrames()  // Update the layer frames to fit
        
        lowerThumbLayer.rangeSlider = self
        upperThumbLayer.rangeSlider = self
    }
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    
    func updateLayerFrames() {
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        
        let lowerThumbCenter = CGFloat(positionForValue(value: lowerValue))
        
        lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2.0, y: 0.0,
                                       width: thumbWidth, height: thumbWidth)
        lowerThumbLayer.setNeedsDisplay()
        
        let upperThumbCenter = CGFloat(positionForValue(value: upperValue))
        upperThumbLayer.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: 0.0,
                                       width: thumbWidth, height: thumbWidth)
        upperThumbLayer.setNeedsDisplay()
    }
    
    
    // Maps a value to a location on screen using a simple ratio to scale the position between the minimum and maximum range of the control
    func positionForValue(value: Double) -> Double {
        return Double(bounds.width - thumbWidth) * (value - minimumValue) /
            (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
    }
    
    // Override frame to implement a property observer that updates the layer frames when the frame changes.
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    
    // Invoked when the user first touches the control. The return value for the method informs the UIControl superclass whether subsequent touches should be tracked.
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        // Hit test the thumb layers
        if lowerThumbLayer.frame.contains(previousLocation) {
            lowerThumbLayer.highlighted = true
        } else if upperThumbLayer.frame.contains(previousLocation) {
            upperThumbLayer.highlighted = true
        }
        
        return lowerThumbLayer.highlighted || upperThumbLayer.highlighted
    }
    
    // Makes sure the passed in value is within the specified range
    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }
    
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        // 1. Determine by how much the user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)
        
        previousLocation = location
        
        // 2. Update the values
        if lowerThumbLayer.highlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(value: lowerValue, toLowerValue: minimumValue, upperValue: upperValue)
        } else if upperThumbLayer.highlighted {
            upperValue += deltaValue
            upperValue = boundValue(value: upperValue, toLowerValue: lowerValue, upperValue: maximumValue)
        }
        
        // 3. Update the UI
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        updateLayerFrames()
        
        CATransaction.commit()
        
        sendActions(for: .valueChanged)     // notify any subscribed targets of the changes
        return true
    }
    
    
    // Handle the end of the touch and drag events. Resets both thumbs to a non-highlighted state.
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbLayer.highlighted = false
        upperThumbLayer.highlighted = false
        
        // MARK: TODO: Make sure both lower and upper value cannot be equal as that would be a loop of zero seconds. Or maybe this is ok???
        
        // Debug
//        print(thumbWidth)
//        print(lowerValue)
//        print(upperValue)
    }
    
    
    
}
