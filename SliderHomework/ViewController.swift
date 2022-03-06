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
    
    @IBOutlet weak var viewColor: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewColor.backgroundColor = .white
    }

    @IBAction func redSliderAction() {
        redValueLabel.text = String(redSlider.value)
         var redColorValue = CGFloat(redSlider.value)
        
        var greenColorValue = CGFloat(greenSlider.value)
        
        var blueColorValue = CGFloat(blueSlider.value)
        
        var color = UIColor(red: redColorValue, green: greenColorValue, blue: blueColorValue, alpha: 1)
        
          self.viewColor.backgroundColor = color
    }
    
    @IBAction func greenSliderAction() {
        greenValueLabel.text = String(greenSlider.value)
        var redColorValue = CGFloat(redSlider.value)
       
       var greenColorValue = CGFloat(greenSlider.value)
       
       var blueColorValue = CGFloat(blueSlider.value)
       
       var color = UIColor(red: redColorValue, green: greenColorValue, blue: blueColorValue, alpha: 1)
       
         self.viewColor.backgroundColor = color
    }
    
    @IBAction func blueSliderAction() {
        blueValueLabel.text = String(blueSlider.value)
        var redColorValue = CGFloat(redSlider.value)
       
       var greenColorValue = CGFloat(greenSlider.value)
       
       var blueColorValue = CGFloat(blueSlider.value)
       
       var color = UIColor(red: redColorValue, green: greenColorValue, blue: blueColorValue, alpha: 1)
       
         self.viewColor.backgroundColor = color
    }
    
   
}
    


