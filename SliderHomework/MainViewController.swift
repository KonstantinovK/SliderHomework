//
//  MainViewController.swift
//  SliderHomework
//
//  Created by MacBook on 18.03.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewColorValue(for red: String, for green: String, for blue: String)
}

class MainViewController: UIViewController {
 
    @IBOutlet var viewBackground: UIView!
    var redValue: CGFloat = 0
    var greenValue: CGFloat = 0
    var blueValue: CGFloat = 0
    var alphaValue: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBackground.backgroundColor = .white
       
    }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let backgroundVC = segue.destination as? ViewController else { return }
            backgroundVC.viewColorVC = viewBackground.backgroundColor
        backgroundVC.delegate = self
    }
}



//MARK: - SettingsViewControllerDelegate

extension MainViewController: SettingsViewControllerDelegate {
       func setNewColorValue(for red: String, for green: String, for blue: String) {
        let backRed = Float(red)
        let backGreen = Float(green)
        let backBlue = Float(blue)
        viewBackground.backgroundColor = UIColor(red: CGFloat(backRed ?? 0), green: CGFloat(backGreen ?? 0), blue: CGFloat(backBlue ?? 0), alpha: 1)
    }
}


extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
