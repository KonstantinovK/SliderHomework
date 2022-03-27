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
    
    
//MARK: -DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewColor.layer.cornerRadius = 14
        
        viewColor.backgroundColor = viewColorVC
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        
        setSliders()
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setValue(for: setRedValueTF, setGreenValueTF, setBlueValueTF)
        
    }
    
//MARK: -IB Actions
    
    @IBAction func sliderAction(_ sender: UISlider) {
        
        switch sender {
        case redSlider:
            setValue(for: redValueLabel)
            setValue(for: setRedValueTF)
        case greenSlider:
            setValue(for: greenValueLabel)
            setValue(for: setGreenValueTF)
        default:
            setValue(for: blueValueLabel)
            setValue(for: setBlueValueTF)
        }
        setColor()
    }
    
    @IBAction func doneButtonPressed() {
        
        delegate?.setColor(viewColor.backgroundColor ?? .white)
        dismiss(animated: true)
    }
}
    
  //MARK: -Private methods
   
    extension ViewController {
    
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
                case redValueLabel: label.text = string(from: redSlider)
                case greenValueLabel: label.text = string(from: greenSlider)
                default: label.text = string(from: blueSlider)
                }
            }
        }
        
        private func setValue(for textFields: UITextField...) {
            textFields.forEach { textField in
                switch textField {
                case setRedValueTF: textField.text = string(from: redSlider)
                case setGreenValueTF: textField.text = string(from: greenSlider)
                default: textField.text = string(from: blueSlider)
                }
            }
        }
        
        private func setSliders() {
            let ciColor = CIColor(color: viewColorVC)
            
            redSlider.value = Float(ciColor.red)
            greenSlider.value = Float(ciColor.green)
            blueSlider.value = Float(ciColor.blue)
        }
        
    // значения цветовые
        
        private func string(from slider: UISlider) -> String {
            String(format: "%.2f", slider.value)
        }
        
        @objc private func didTapDone() {
            view.endEditing(true)
        }
        
        private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }



//MARK: - Extensions

extension ViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //метод вызова тулбара над клавиатурой
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            switch textField {
            case setRedValueTF:
                redSlider.setValue(currentValue, animated: true)
                setValue(for: redValueLabel)
            case setGreenValueTF:
                greenSlider.setValue(currentValue, animated: true)
                setValue(for: greenValueLabel)
            default:
                blueSlider.setValue(currentValue, animated: true)
                setValue(for: blueValueLabel)
            }
            setColor()
            return
        }
        showAlert(title: "Wrong format!", message: "Please enter correct value")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        keyboardToolbar.items = [flexBarButton, doneButton]
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
    


