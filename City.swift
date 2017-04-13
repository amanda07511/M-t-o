//
//  City.swift
//  Météo
//
//  Created by Amanda Michelle Marroquin Delgado on 15/02/2017.
//  Copyright © 2017 Amanda Michelle Marroquin Delgado. All rights reserved.
//

import UIKit
import os.log

class City: NSObject, NSCoding {
    
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
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("cities")
    
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
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: PropertyKey.id)
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(wMain, forKey: PropertyKey.wMain)
        aCoder.encode(wDescription, forKey: PropertyKey.wDescription)
        aCoder.encode(temp, forKey: PropertyKey.temp)
        aCoder.encode(tempmax, forKey: PropertyKey.tempmax)
        aCoder.encode(tempmin, forKey: PropertyKey.tempmin)
        aCoder.encode(presure, forKey: PropertyKey.presure)
        aCoder.encode(humidity, forKey: PropertyKey.humidity)
        aCoder.encode(icon, forKey: PropertyKey.icon)
    
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The id is required. If we cannot decode a id string, the initializer should fail.
        guard let id = aDecoder.decodeInteger(forKey: PropertyKey.id) as? Int else {
            os_log("Unable to decode the id for the City object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        let wMain = aDecoder.decodeObject(forKey: PropertyKey.wMain) as? String
        let wDescription = aDecoder.decodeObject(forKey: PropertyKey.wDescription) as? String
        let temp = aDecoder.decodeDouble(forKey: PropertyKey.temp) as Double
        let tempmax = aDecoder.decodeDouble(forKey: PropertyKey.tempmax) as Double
        let tempmin = aDecoder.decodeDouble(forKey: PropertyKey.tempmin) as Double
        let presure = aDecoder.decodeDouble(forKey: PropertyKey.presure) as Double
        let humidity = aDecoder.decodeDouble(forKey: PropertyKey.humidity) as Double
        let icon = aDecoder.decodeObject(forKey: PropertyKey.icon) as? String
        
        // Must call designated initializer.
        self.init(id: id, name: name!, wMain: wMain!, wDescription: wDescription! , temp: temp, tempmax: tempmax, tempmin: tempmin, presure: presure, humidity: humidity, icon:icon!  )
        
    }
    
}
