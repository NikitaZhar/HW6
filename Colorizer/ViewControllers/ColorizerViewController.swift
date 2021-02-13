//
//  ViewController.swift
//  Colorizer
//
//  Created by Nikita Zharinov on 12/02/2021.
//

import UIKit

class ColorizerViewController: UIViewController {
    
    var redComponent: CGFloat = 0
    var greenComponent: CGFloat = 0
    var blueComponent: CGFloat = 0
    var alphaComponent: CGFloat = 1
    
    var selectedColor = UIColor(
        red: CGFloat(0),
        green: CGFloat(0.5),
        blue: CGFloat(0),
        alpha: 1.0)
    
    @IBOutlet var initialView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialView.backgroundColor = selectedColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.initialViewColor = selectedColor
    }
}

