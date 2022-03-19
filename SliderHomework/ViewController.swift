//
//  ViewController.swift
//  SliderHomework
//
//  Created by MacBook on 05.03.2022.
//

import UIKit
import Foundation


class ViewController: UIViewController {
//MARK: - Outlets and properties
    
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
    
    var delegate: SettingsViewControllerDelegate!
    var viewColorVC: UIColor!
    var redValue: CGFloat = 0
    var greenValue: CGFloat = 0
    var blueValue: CGFloat = 0
    var alphaValue: CGFloat = 0
    
    
//MARK: -DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewColor.layer.cornerRadius = 14
        viewColorVC.getRed(&redValue, green: &greenValue, blue: &blueValue, alpha: &alphaValue)
        
        viewColor.backgroundColor = UIColor(
            red: redValue,
            green: greenValue,
            blue: blueValue,
            alpha: alphaValue
        )
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        
        setRedValueTF.keyboardType = .decimalPad
        setRedValueTF.returnKeyType = .next
        setRedValueTF.delegate = self
        
        setGreenValueTF.keyboardType = .decimalPad
        setGreenValueTF.returnKeyType = .next
        setGreenValueTF.delegate = self
        
        setBlueValueTF.keyboardType = .decimalPad
        setBlueValueTF.returnKeyType = .done
        setBlueValueTF.delegate = self
        
    }
    
//MARK: -IB Actions
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redValueLabel.text = string2value(from: redSlider)
            setRedValueTF.text = string2value(from: redSlider)
        case greenSlider:
            greenValueLabel.text = string2value(from: greenSlider)
            setGreenValueTF.text = string2value(from: greenSlider)
        default:
            blueValueLabel.text = string2value(from: blueSlider)
            setBlueValueTF.text = string2value(from: blueSlider)
        }
    }
    
    @IBAction func doneButtonPressed() {
        
        redValueLabel.text = setRedValueTF.text
        greenValueLabel.text = setGreenValueTF.text
        blueValueLabel.text = setBlueValueTF.text
        
        redSlider.value = string2float(from: setRedValueTF)
        greenSlider.value = string2float(from: setGreenValueTF)
        blueSlider.value = string2float(from: setBlueValueTF)
        
        setColor()
        
        delegate.setNewColorValue(for: setRedValueTF.text ?? "0", for: setGreenValueTF.text ?? "0", for: setBlueValueTF.text ?? "0")
        dismiss(animated: true, completion: nil)
    }
    
  //MARK: -Private methods
    
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
                setRedValueTF.text = string2value(from: redSlider)
            case greenValueLabel:
                greenValueLabel.text = string2value(from: greenSlider)
                setGreenValueTF.text = string2value(from: greenSlider)
            default:
                blueValueLabel.text = string2value(from: blueSlider)
                setBlueValueTF.text = string2value(from: blueSlider)
            }
        }
    }
    
    private func string2value(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func string2float(from field: UITextField) -> Float {
        (field.text! as NSString).floatValue
    }
}



//MARK: - Extensions

extension ViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == setRedValueTF {
            setGreenValueTF.becomeFirstResponder()
        } else if textField == setGreenValueTF {
            setBlueValueTF.becomeFirstResponder()
        } else {
            doneButtonPressed()
        }
        return true
    }
}

extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
        
    }
}
    


