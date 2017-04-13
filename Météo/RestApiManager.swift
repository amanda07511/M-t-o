//
//  RestApiManager.swift
//  Météo
//
//  Created by Amanda Michelle Marroquin Delgado on 15/02/2017.
//  Copyright © 2017 Amanda Michelle Marroquin Delgado. All rights reserved.
//

import Foundation


var city: City?
var details = [Detail]()

func getDataCity(cityName: String,taskCallback: @escaping (Bool,
    City?) -> ())   {
    
    print(cityName)
    
    // Set up the URL request
    let urlData: String = "http://api.openweathermap.org/data/2.5/weather"
    
    let urlWithParams = urlData + "?q=\(cityName)&appid=8f9b643f5dc4ec22141666eefbcf7e14"
    let urlwithPercentEscapes = urlWithParams.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
    
    guard let url = URL(string: urlwithPercentEscapes!) else {
        print("Error: cannot create URL")
        taskCallback(false, nil)
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
            
            //Check that is not an error code
            guard let cod = data["cod"] as? Int else{
                taskCallback(false, nil)
                return
            }//else
            
            print("Code: " + String(cod))
            
            
            // now we have the data, let's just print it to prove we can access it
            print("Wheather data: " + (data["weather"]?.description)!)
            
            guard let weather = data["weather"]![0] as? [String: Any],
                let name = data["name"] as? String,
                let id = data["id"] as? Int,
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
            
    
            
            city = City(id: id, name: name, wMain: wMain, wDescription: description, temp: temp, tempmax: tempmax, tempmin: tempmin, presure: presure, humidity: humidity, icon: wIcon)
            
            taskCallback(true, city as City?)
            
        }//do
        catch  {
            print("error trying to convert data to JSON")
            
        }//catch
    }
    
    task.resume()
    
    
}//FIN getDataCity




func getDataDetails(cityId: Int,taskCallback: @escaping (Bool,
    [Detail]) -> ())   {
    
    print(cityId)
    
    // Set up the URL request
    let urlData: String = "http://api.openweathermap.org/data/2.5/forecast/daily"
    
    let urlWithParams = urlData + "?id=\(cityId)&appid=f91dae57a87b7315df8a12b38fee2ed5&cnt=16"
    
    guard let url = URL(string: urlWithParams) else {
        print("Error: cannot create URL")
        return
    }
    let urlRequest = URLRequest(url: url)
    
    
    
    // set up the session
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    
    // make the request
    let task = session.dataTask(with: urlRequest as URLRequest) {
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
            print("Data: " + ((data["cod"])! as! String))
            
            guard let cod = data["cod"] as? String else{
                print("Could not get code from JSON")
                return
            }//else
            
            print("Code: " + (cod))
            
            if(cod == "500"){
                taskCallback(false, details as [Detail])
                return
            }
            
            guard let cnt = data["cnt"] as? Int else{
                print("Could not get cnt weather from JSON")
                return
            }//else
            
        
            
            details.removeAll()
            for index in 0...(cnt-1) {
                
                guard let detail = data["list"]![index] as? [String: AnyObject],
                    let weather = detail["weather"]![0] as? [String: Any],
                    let dt = detail["dt"] as? Int,
                    let main = detail["temp"] as? [String: Double],
            
                    let description = weather["description"] as? String,
                    let icon = weather["icon"] as? String,
                    
                    
                    let temp = main["day"],
                    let tempmax = main["max"],
                    let tempmin = main["min"],
                    let morn = main["morn"],
                    let eve = main["eve"],
                    let night = main["night"]
                
                else {
                    print("Could not get detail weather from JSON")
                    return
                }//else
                
                guard let detail1 = Detail(dt: dt, description: description, temp: temp, tempmax: tempmax, tempmin: tempmin, morn: morn, eve: eve, night: night, icon: icon)else {
                    fatalError("Unable to instantiate meal1")
                }
                
                details.append(detail1)
                
                
            }
            
            
            taskCallback(true, details as [Detail])
            
        }//do
        catch  {
            print("error trying to convert data to JSON")
            
        }//catch
    }
    
    task.resume()
    
    
}//FIN getDataDetails

func getDataCityId(cityId: Int,taskCallback: @escaping (Bool,
    City?) -> ())   {
    
    print(cityId)
    
    // Set up the URL request
    let urlData: String = "http://api.openweathermap.org/data/2.5/weather"
    
    let urlWithParams = urlData + "?id=\(cityId)&appid=8f9b643f5dc4ec22141666eefbcf7e14"
    
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
            
            //Check that is not an error code
            guard let cod = data["cod"] as? Int else{
                taskCallback(false, nil)
                return
            }//else
            
            print("Code: " + String(cod))
            
            
            // now we have the data, let's just print it to prove we can access it
            print("Wheather data: " + (data["weather"]?.description)!)
            
            guard let weather = data["weather"]![0] as? [String: Any],
                let name = data["name"] as? String,
                let id = data["id"] as? Int,
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
            
            
            
            city = City(id: id, name: name, wMain: wMain, wDescription: description, temp: temp, tempmax: tempmax, tempmin: tempmin, presure: presure, humidity: humidity, icon: wIcon)
            
            taskCallback(true, city as City?)
            
        }//do
        catch  {
            print("error trying to convert data to JSON")
            
        }//catch
    }
    
    task.resume()
    
    
}//FIN getDataCityId











