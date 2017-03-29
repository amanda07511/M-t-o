//
//  City.swift
//  Météo
//
//  Created by Amanda Michelle Marroquin Delgado on 15/02/2017.
//  Copyright © 2017 Amanda Michelle Marroquin Delgado. All rights reserved.
//

import UIKit

class City {
    
    //MARK: Properties
    
    var name: String
    var wMain: String
    var wDescription: String
    var temp: Double
    var tempmax: Double
    var tempmin: Double
    var presure: Double
    var humidity: Double
    var icon: String
    
    init?(name: String, wMain: String, wDescription: String, temp: Double, tempmax: Double, tempmin: Double, presure: Double, humidity: Double, icon: String  ) {
        
        // Initialization should fail if there is no name.
        guard !name.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.wMain = wMain
        self.wDescription = wDescription
        self.temp = temp
        self.tempmax = tempmax
        self.tempmin = tempmin
        self.presure = presure
        self.humidity = humidity
        self.icon = icon
        
    }
    
}
