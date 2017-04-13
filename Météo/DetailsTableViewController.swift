//
//  DetailsTableViewController.swift
//  Météo
//
//  Created by Amanda Michelle Marroquin Delgado on 11/04/2017.
//  Copyright © 2017 Amanda Michelle Marroquin Delgado. All rights reserved.
//

import UIKit


class DetailsTableViewController: UITableViewController {
    
    //--->MARK: Properties
    var id: Int?
    var details = [Detail]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        details.removeAll();
        loadDetails()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return details.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DetailsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DetailsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of DetailsTableViewCell.")
        }
        
        let detail = details[indexPath.row]
        print(details.count)
        
        let photo1 = UIImage(named: detail.icon)
        let date = getDate(unixdate: detail.dt)
        
        let temp = detail.temp - 273.15
        let tempmax = detail.tempmax - 273.15
        let tempmin = detail.tempmin - 273.15
        let morn = detail.morn - 273.15
        let eve = detail.eve - 273.15
        let night = detail.night - 273.15
        
        cell.titleLabel.text = date.description
        cell.photoImageView.image = photo1
        cell.weatherLabel.text = detail.description
        cell.tempLabel.text = String(format: "%.2f", temp)+"°C"
        cell.maxLabel.text = "max:"+String(format: "%.2f", tempmax)+"°C"
        cell.minLabel.text = "min:"+String(format: "%.2f", tempmin)+"°C"
        cell.mornLabel.text = "morn:"+String(format: "%.1f", morn)+"°C"
        cell.eveLabel.text = "eve:"+String(format: "%.1f", eve)+"°C"
        cell.nightLabel.text = "night:"+String(format: "%.1f", night)+"°C"
        

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
    
    //MARK: Private Methods
    
    private func loadDetails() {
        
        getDataDetails(cityId: id!) { (ok, objs ) in
            self.details = objs
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    private func getDate(unixdate: Int) -> String {
        if unixdate == 0 {return ""}
        let date = NSDate(timeIntervalSince1970: TimeInterval(unixdate))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
        dayTimePeriodFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    

}
