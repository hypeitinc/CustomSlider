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
    var highlighted = false
    weak var rangeSlider: RangeSlider?
}
