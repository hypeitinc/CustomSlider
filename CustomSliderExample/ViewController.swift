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
        
        view.addSubview(rangeSlider)
        
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged), for: .valueChanged)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            self.rangeSlider.trackHighlightTintColor = UIColor.red
            self.rangeSlider.curvaceousness = 0.0
        }
    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        rangeSlider.frame = CGRect(x: margin, y: margin + topLayoutGuide.length,
                                   width: width, height: 31.0)
    }
    
    
    @objc func rangeSliderValueChanged(rangeSlider: RangeSlider) {
        print("Range slider value changed: \(rangeSlider.lowerValue) \(rangeSlider.upperValue)")
    }
    
    
}
