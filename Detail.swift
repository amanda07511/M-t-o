//
//  Detail.swift
//  Météo
//
//  Created by Amanda Michelle Marroquin Delgado on 11/04/2017.
//  Copyright © 2017 Amanda Michelle Marroquin Delgado. All rights reserved.
//

import UIKit

class Detail {
    
    //MARK: Properties
    var dt: Int
    var description: String
    var temp: Double
    var tempmax: Double
    var tempmin: Double
    var morn: Double
    var eve: Double
    var night: Double
    var icon: String
    
    init?(dt:Int, description: String, temp: Double, tempmax: Double, tempmin: Double, morn: Double, eve: Double, night: Double, icon: String  ) {
        
        // Initialization should fail if there is no description.
        guard !description.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.dt = dt
        self.description = description
        self.temp = temp
        self.tempmax = tempmax
        self.tempmin = tempmin
        self.morn = morn
        self.eve = eve
        self.night = night
        self.icon = icon
        
    }
    
    
}
