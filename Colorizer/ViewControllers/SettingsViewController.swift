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
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    var mainScreenColor: UIColor!
    var newColor: UIColor!
    var delegate: SettingsViewControllerDeledate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
        coloredView.layer.cornerRadius = 10
        navigationItem.hidesBackButton = true
        
        redTF.addDoneCancelToolbar(onDone: (target: self, action: #selector(self.tapDone)))
        greenTF.addDoneCancelToolbar(onDone: (target: self, action: #selector(self.tapDone)))
        blueTF.addDoneCancelToolbar(onDone: (target: self, action: #selector(self.tapDone)))
        updateElements()
    }
    
    @IBAction func rgbSliderAction(_ sender: UISlider) {
        switch sender.tag {
        case 1: redLabel.text = setColorLabel(for: sender)
            redTF.text = redLabel.text
        case 2: greenLabel.text = setColorLabel(for: sender)
            greenTF.text = greenLabel.text
        case 3: blueLabel.text = setColorLabel(for: sender)
            blueTF.text = blueLabel.text
        default: break
        }
        setNewColour()
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        setNewColour()
        delegate.setNewColor(with: newColor)
        dismiss(animated: true)
    }
    
//MARK: - Setting color
    private func settingViewColor() {
        coloredView.backgroundColor = newColor
    }
    
    private func updateElements() {
        let red = Float(mainScreenColor.rgba.redComponent)
        let green = Float(mainScreenColor.rgba.greenComponent)
        let blue = Float(mainScreenColor.rgba.blueComponent)
        
        redSlider.setValue(red, animated: true)
        greenSlider.setValue(green, animated: true)
        blueSlider.setValue(blue, animated: true)
        
        redLabel.text = String(format: "%.2f", red)
        greenLabel.text = String(format: "%.2f", green)
        blueLabel.text = String(format: "%.2f", blue)
        
        redTF.text = String(format: "%.2f", red)
        greenTF.text = String(format: "%.2f", green)
        blueTF.text = String(format: "%.2f", blue)
        
        setNewColour()
    }
    
    private func setNewColour() {
        newColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
        coloredView.backgroundColor = newColor
    }
    
    private func setColorLabel (for slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    @objc func tapDone() {
        doneButtonPressed()
    }
}

// MARK: - UIColor

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

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue) else { return }
        
        switch textField.tag {
        case 1: redSlider.setValue(numberValue, animated: true)
            redLabel.text = String(format: "%.2f", numberValue)
        case 2: greenSlider.setValue(numberValue, animated: true)
            greenLabel.text = String(format: "%.2f", numberValue)
        case 3: blueSlider.setValue(numberValue, animated: true)
            blueLabel.text = String(format: "%.2f", numberValue)
        default: break
        }
        setNewColour()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        doneButtonPressed()
        return true
    }

}

// MARK: - Add DONE to keyboard

extension UITextField {
func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
//    let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
    let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

    let toolbar: UIToolbar = UIToolbar()
    toolbar.barStyle = .default
    toolbar.items = [
//        UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
        UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
    ]
    toolbar.sizeToFit()

    self.inputAccessoryView = toolbar
}

    @objc func doneButtonTapped() { self.resignFirstResponder() }}
//    @objc func cancelButtonTapped() { self.resignFirstResponder() }}
