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
    var id: Int
    var name: String
    var wMain: String
    var wDescription: String
    var temp: Double
    var tempmax: Double
    var tempmin: Double
    var presure: Double
    var humidity: Double
    var icon: String
    
    //MARK: Types
    
    struct PropertyKey {
        static let id = "id"
        static let name = "name"
        static let wMain = "wMain"
        static let wDescription = "wDescription"
        static let temp = "temp"
        static let tempmax = "tempmax"
        static let tempmin = "tempmin"
        static let presure = "presure"
        static let humidity = "humidity"
        static let icon = "icon"
    }
    
    init?(id:Int, name: String, wMain: String, wDescription: String, temp: Double, tempmax: Double, tempmin: Double, presure: Double, humidity: Double, icon: String  ) {
        
        // Initialization should fail if there is no name.
        guard !name.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.id = id
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
