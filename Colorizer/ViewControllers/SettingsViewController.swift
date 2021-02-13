//
//  SettingsViewController.swift
//  Colorizer
//
//  Created by Nikita Zharinov on 12/02/2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var coloredView: UIView!
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    var initialViewColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coloredView.layer.cornerRadius = 10
        navigationItem.hidesBackButton = true
        updateElements() 
    }
    
    @IBAction func rgbSliderAction(_ sender: UISlider) {
        switch sender.tag {
        case 1: redLabel.text = setColorLabel(for: sender)
        case 2: greenLabel.text = setColorLabel(for: sender)
        case 3: blueLabel.text = setColorLabel(for: sender)
        default: break
        }
        settingColor()
    }
    
    @IBAction func doneButtonPressed() {
    }
    
    
//MARK: - Setting color
    private func settingColor() {
        coloredView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
    
    private func updateElements() {
        redSlider.setValue(Float(initialViewColor.rgba.redComponent),
                           animated: true)
        greenSlider.setValue(Float(initialViewColor.rgba.greenComponent),
                           animated: true)
        blueSlider.setValue(Float(initialViewColor.rgba.blueComponent),
                           animated: true)
        
        rgbSliderAction(redSlider)
        rgbSliderAction(greenSlider)
        rgbSliderAction(blueSlider)
    }
    
    private func setColorLabel (for slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension UIColor {
    var rgba: (redComponent: CGFloat, greenComponent: CGFloat, blueComponent: CGFloat, alpha: CGFloat) {
        var redComponent: CGFloat = 0
        var greenComponent: CGFloat = 0
        var blueComponent: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&redComponent, green: &greenComponent, blue: &blueComponent, alpha: &alpha)

        return (redComponent, greenComponent, blueComponent, alpha)
    }
}
