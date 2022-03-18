//
//  ViewController.swift
//  SliderHomework
//
//  Created by MacBook on 05.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet var setRedValueTF: UITextField!
    @IBOutlet var setGreenValueTF: UITextField!
    @IBOutlet var setBlueValueTF: UITextField!
    
    @IBOutlet var doneButtonLabel: UIButton!
    
    @IBOutlet weak var viewColor: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewColor.layer.cornerRadius = 14
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        setColor()
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
    }

    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redValueLabel.text = string2value(from: redSlider)
        case greenSlider:
            greenValueLabel.text = string2value(from: greenSlider)
        default:
            blueValueLabel.text = string2value(from: blueSlider)
        }
    }
    
    private func setColor() {
        viewColor.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
                case redValueLabel:
                redValueLabel.text = string2value(from: redSlider)
            case greenValueLabel:
                greenValueLabel.text = string2value(from: greenSlider)
            default:
                blueValueLabel.text = string2value(from: blueSlider)
            }
        }
    }
    
    private func string2value(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
}
