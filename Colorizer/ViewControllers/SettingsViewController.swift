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
    
    var mainScreenColor: UIColor!
    var newColor: UIColor!
    var delegate: SettingsViewControllerDeledate!
    
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
        delegate.setNewColor(with: newColor)
        dismiss(animated: true)
    }
    
//MARK: - Setting color
    private func settingColor() {
        newColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
        coloredView.backgroundColor = newColor
    }
    
    private func updateElements() {
        let red = Float(mainScreenColor.rgba.redComponent)
        let green = Float(mainScreenColor.rgba.greenComponent)
        let blue = Float(mainScreenColor.rgba.blueComponent)
        
        redSlider.setValue(red, animated: true)
        greenSlider.setValue(green, animated: true)
        blueSlider.setValue(blue, animated: true)
        
        redLabel.text = String(red)
        greenLabel.text = String(green)
        blueLabel.text = String(blue)
        
        settingColor()
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
        var alpha: CGFloat = 1
        getRed(&redComponent, green: &greenComponent, blue: &blueComponent, alpha: &alpha)
        
        return (redComponent, greenComponent, blueComponent, alpha)
    }
}
