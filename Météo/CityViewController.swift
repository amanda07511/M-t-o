//
//  CityViewController.swift
//  Météo
//
//  Created by Amanda Michelle Marroquin Delgado on 15/02/2017.
//  Copyright © 2017 Amanda Michelle Marroquin Delgado. All rights reserved.
//

import UIKit

class CityViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherTitle: UILabel!
    @IBOutlet weak var weatherSubtitle: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var presure: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    var cityName: String? = ""
    var city: City?
    var citySave: City?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        saveButton.isHidden = true
        label1.isHidden = true
        label2.isHidden = true
        label3.isHidden = true
        label4.isHidden = true
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        cityName = textField.text
        
        //Calling callback of getDatacity
        getDataCity(cityName: cityName!){ (ok, obj) in
            
            guard let city = obj else {
                return
            }
            
            let photo1 = UIImage(named: city.icon)
            let tempeture = city.temp - 273.15
            let tempetureMin = city.tempmin - 273.15
            let tempetureMax = city.tempmax - 273.15
            
            //It call
            DispatchQueue.main.async {
                
                self.photo.image = photo1
                self.weatherTitle.text = city.name + " " + tempeture.description + "°C"
                self.weatherSubtitle.text = city.wDescription
                self.tempMax.text = tempetureMin.description + "°C"
                self.tempMin.text = tempetureMax.description + "°C"
                self.presure.text = city.presure.description
                self.humidity.text = city.humidity.description
                self.saveButton.isHidden = false
                self.label1.isHidden = false
                self.label2.isHidden = false
                self.label3.isHidden = false
                self.label4.isHidden = false
                
            }
        }
        

        
    }
    
    
    //--->MARK: Private Methods
    
    

}

