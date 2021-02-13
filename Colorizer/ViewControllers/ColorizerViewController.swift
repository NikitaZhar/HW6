//
//  ViewController.swift
//  Colorizer
//
//  Created by Nikita Zharinov on 12/02/2021.
//

import UIKit

protocol SettingsViewControllerDeledate {
    func setNewColor(with newColor: UIColor)
}

class ColorizerViewController: UIViewController {
    
    var mainScreenColor = UIColor(
        red: CGFloat(0.5),
        green: CGFloat(0.5),
        blue: CGFloat(0.5),
        alpha: 1.0)
    
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = mainScreenColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.mainScreenColor = mainScreenColor
        settingsVC.delegate = self
    }
}

extension ColorizerViewController: SettingsViewControllerDeledate {
    func setNewColor(with newColor: UIColor) {
        mainScreenColor = newColor
        mainView.backgroundColor = newColor
    }
}
