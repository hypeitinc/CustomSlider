//
//  ViewController.swift
//  CustomSliderExample
//
//  Created by Peter Rexelius on 4/25/18.
//  Copyright © 2018 HYPEIT INC. Peter Rexelius. All rights reserved.
//

import UIKit

#if targetEnvironment(simulator)
    import AVFoundation
#endif


class ViewController: UIViewController {

    let slider1 = RangeSlider(frame: CGRect.zero)

    @IBOutlet weak var slider2: RangeSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = UIColor.darkGray
        slider1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider1)
        slider1.backgroundColor = UIColor.clear
        slider1.addTarget(self, action: #selector(rangeSliderValueChanged), for: .valueChanged)
        slider1.hapticsOn = true
        slider1.discreteSteps = 10
        slider1.minimumValue = 0.0
        slider1.maximumValue = 100.0
        slider1.lowerValue = 20.0
        slider1.upperValue = 80.0

    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        let topMargin = slider1.safeAreaInsets.top + 20.0
        slider1.frame = CGRect(x: margin, y: margin + topMargin, width: width, height: 40.0)
        
        self.slider1.thumbType = 0              // e.g. number of corners:  0 = circle, 2 = line, 3 = triangle, 4 = square
        self.slider1.curvaceousness = 1.0       // 0.0 - 1.0   only applies to the circle and the track   0 -> square
        self.slider1.trackSizeScale = 0.5       // e.g. 0.2 to get a thinner track while maintaining normal size thumbs
        
        self.slider1.trackTintColor = UIColor.gray
        self.slider1.trackHighlightTintColor = UIColor.red
        self.slider1.thumbLineWidth = 1.5
        self.slider1.thumbStrokeColor = UIColor.white
        self.slider1.thumbTintColor = UIColor.orange
        
    }
    
    
    @objc func rangeSliderValueChanged(rangeSlider: RangeSlider) {
        print("Slider1: \(rangeSlider.lowerValue) \(rangeSlider.upperValue)")
        #if targetEnvironment(simulator)
        if slider1.hapticsOn {
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(1306)) {
                //completion here
            }
        }
        #endif
    }
    
    @IBAction func slider2ValueChanged(_ sender: RangeSlider) {
        print("Slider2: \(sender.lowerValue) \(sender.upperValue)")
        #if targetEnvironment(simulator)
        if slider1.hapticsOn {
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(1306)) {
                //completion here
            }
        }
        #endif
    }
    

}
