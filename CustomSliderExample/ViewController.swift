//
//  ViewController.swift
//  CustomSliderExample
//
//  Created by Peter Rexelius on 4/25/18.
//  Copyright © 2018 HYPEIT INC. Peter Rexelius. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let rangeSlider = RangeSlider(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        
        view.addSubview(rangeSlider)
        rangeSlider.backgroundColor = UIColor.darkGray
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged), for: .valueChanged)
        
    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        rangeSlider.frame = CGRect(x: margin, y: margin + topLayoutGuide.length,
                                   width: width, height: 32.0)
        self.rangeSlider.thumbType = 3              // e.g. number of corners:  0 = circle , 3 = triangle, 4 = square
        self.rangeSlider.curvaceousness = 0.6       // 0.0 - 1.0   only applies to the circle and the track   0 -> square
        self.rangeSlider.trackSizeScale = 0.25      // to get a thinner track while maintaining normal size thumbs
        
        self.rangeSlider.trackTintColor = UIColor.gray
        self.rangeSlider.trackHighlightTintColor = UIColor.red
        self.rangeSlider.thumbTintColor = UIColor.orange
    }
    
    
    @objc func rangeSliderValueChanged(rangeSlider: RangeSlider) {
        print("Range slider value changed: \(rangeSlider.lowerValue) \(rangeSlider.upperValue)")
    }
    
    
}
