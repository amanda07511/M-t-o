//
//  RestApiManager.swift
//  Météo
//
//  Created by Amanda Michelle Marroquin Delgado on 15/02/2017.
//  Copyright © 2017 Amanda Michelle Marroquin Delgado. All rights reserved.
//

import Foundation


var city: City?

func getDataCity(cityName: String,taskCallback: @escaping (Bool,
    City?) -> ())   {
    
    print(cityName)
    
    // Set up the URL request
    let urlData: String = "http://api.openweathermap.org/data/2.5/weather"
    
    let urlWithParams = urlData + "?q=\(cityName)&appid=8f9b643f5dc4ec22141666eefbcf7e14"
    
    guard let url = URL(string: urlWithParams) else {
        print("Error: cannot create URL")
        return
    }
    let urlRequest = URLRequest(url: url)
    
    
    
    // set up the session
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    
    
    // make the request
    let task = session.dataTask(with: urlRequest) {
        (data, response, error) in
        // check for any errors
        guard error == nil else {
            print("error calling GET")
            print(error!)
            return
        }
        // make sure we got data
        guard let responseData = data else {
            print("Error: did not receive data")
            return
        }
        // parse the result as JSON, since that's what the API provides
        do {
            guard let data = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                print("error trying to convert data to JSON")
                return
            }
            // now we have the data, let's just print it to prove we can access it
            print("Wheather data: " + (data["weather"]?.description)!)
            
            guard let cod = data["cod"] as? Int else{
                print("Could not get city weather from JSON")
                return
            }//else
            
        
            
            guard let weather = data["weather"]![0] as? [String: Any],
                let description = weather["description"] as? String,
                let wMain = weather["main"] as? String,
                let wIcon = weather["icon"] as? String,
                let main = data["main"] as? [String: Double],
                let temp = main["temp"],
                let tempmax = main["temp_max"],
                let tempmin = main["temp_min"],
                let presure = main["pressure"],
                let humidity = main["humidity"]
                
            else {
                print("Could not get city weather from JSON")
                return
            }//else
            
            print("Code: " + String(cod))
            
            
            
            
            city = City(name: cityName, wMain: wMain, wDescription: description, temp: temp, tempmax: tempmax, tempmin: tempmin, presure: presure, humidity: humidity, icon: wIcon)
            
            taskCallback(true, city as City?)
            
        }//do
        catch  {
            print("error trying to convert data to JSON")
            
        }//catch
    }
    
    task.resume()
    
    
}//FIN getDataCity











