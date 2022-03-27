//
//  MainViewController.swift
//  SliderHomework
//
//  Created by MacBook on 18.03.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class MainViewController: UIViewController {
    
    @IBOutlet var viewBackground: UIView!
    
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
    func setColor(_ color: UIColor) {
        viewBackground.backgroundColor = color
    }
}


