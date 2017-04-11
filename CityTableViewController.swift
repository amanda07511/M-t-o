//
//  CityTableViewController.swift
//  Météo
//
//  Created by Amanda Michelle Marroquin Delgado on 29/03/2017.
//  Copyright © 2017 Amanda Michelle Marroquin Delgado. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController {
    
    var cities = [City]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleCities()
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
        
        
        cell.titleLabel.text = city.name + " "+city.temp.description+"°C"
        cell.minLabel.text = "min: "+city.tempmin.description+"°C"
        cell.maxLabel.text = "max: "+city.tempmax.description+"°C"
        cell.pressLabel.text = "pres: "+city.presure.description
        cell.humLabel.text = "hum: "+city.humidity.description
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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
     
     
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToCitylList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? CityViewController, let city = sourceViewController.city {
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: cities.count, section: 0)
            
            cities.append(city)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    
    
    //MARK: Private Methods
    
    private func loadSampleCities() {
        
        guard let city1 = City(id: 3014728, name: "Grenoble", wMain: "Clear", wDescription: "Clear Sky", temp: 12.5, tempmax: 19, tempmin: 5, presure: 95.5, humidity: 12.8, icon: "01d") else {
            fatalError("Unable to instantiate city1")
        }
        cities += [city1]

        
    }
}
