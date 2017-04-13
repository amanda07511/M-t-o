//
//  CityTableViewController.swift
//  Météo
//
//  Created by Amanda Michelle Marroquin Delgado on 29/03/2017.
//  Copyright © 2017 Amanda Michelle Marroquin Delgado. All rights reserved.
//

import UIKit
import os.log

class CityTableViewController: UITableViewController {
    
    var cities = [City]()
    var details = [Detail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem

        // Load any saved cities, otherwise load sample data.
        if let savedCities = loadCities() {
            for city in savedCities{
                reloadCities(id: city.id)
            }
            //cities += savedCities
            //reloadCities(id: 3014728 )
        }
        else {
            // Load the sample data.
            loadSampleCities()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CityTableViewCell"
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CityTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CityTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let city = cities[indexPath.row]
        
        let tempeture = city.temp - 273.15
        let tempetureMin = city.tempmin - 273.15
        let tempetureMax = city.tempmax - 273.15
        
        cell.titleLabel.text = city.name + " "+String(format: "%.2f",tempeture)+"°C"
        cell.minLabel.text = "min: "+String(format: "%.2f",tempetureMin)+"°C"
        cell.maxLabel.text = "max: "+String(format: "%.2f",tempetureMax)+"°C"
        cell.pressLabel.text = "pres: "+String(format: "%.2f",city.presure)+" hPa"
        cell.humLabel.text = "hum: "+String(format: "%.2f",city.humidity)+"%"
        cell.photoImageView.image = UIImage(named: city.icon)
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        saveCities()
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
     
     
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "addItem":
            os_log("Adding a new City.", log: OSLog.default, type: .debug)
            
        case "showDetails":
            guard let detailsTableViewController = segue.destination as? DetailsTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCityCell = sender as? CityTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedCityCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedCity = cities[indexPath.row]
            
            
            let id = selectedCity.id
            detailsTableViewController.id = id
            //loadDetails(id: selectedCity.id)
            
            
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }

    }
    
    
    @IBAction func unwindToCitylList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? CityViewController, let city = sourceViewController.city {
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: cities.count, section: 0)
            
            cities.append(city)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
        saveCities()
    }
    
    
    
    //MARK: Private Methods
    
    private func loadSampleCities() {
        
        guard let city1 = City(id: 3014728, name: "Grenoble", wMain: "Clear", wDescription: "Clear Sky", temp: 12.5, tempmax: 19, tempmin: 5, presure: 95.5, humidity: 12.8, icon: "01d") else {
            fatalError("Unable to instantiate city1")
        }
        cities += [city1]

        
    }
    
    private func saveCities() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(cities, toFile: City.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Cities successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadCities() -> [City]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: City.ArchiveURL.path) as? [City]
    }
    
    private func reloadCities(id: Int){
        
        getDataCityId(cityId: id){ (ok, obj) in
            guard let city = obj else {
                print("Estoy vacio :(")
                return
            }
            self.cities.append(city)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
