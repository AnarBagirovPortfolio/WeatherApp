//
//  CitiesViewController.swift
//  MyWeatherApp
//
//  Created by Faannaka on 30.03.16.
//  Copyright © 2016 Faannaka. All rights reserved.
//

import UIKit

class CitiesViewController: UITableViewController {
    
    var downloadedData : [CurrentData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //Add bottom padding
        let inset = UIEdgeInsetsMake(0, 0, 8, 0);
        self.tableView.contentInset = inset;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell", forIndexPath: indexPath) as! WeatherCell
        
        var data : CurrentData
        var city : String
        
        if indexPath.row == 0 {
            city =  "Baku"
        }
        else if indexPath.row == 1 {
            city =  "London"
        }
        else if indexPath.row == 2 {
            city =  "New York"
        }
        else if indexPath.row == 3 {
            city =  "Berlin"
        }
        else if indexPath.row == 4 {
            city =  "Roma,Italy"
        }
        else if indexPath.row == 5 {
            city =  "Madrid"
        }
        else if indexPath.row == 6 {
            city =  "Paris"
        }
        else {
            city =  "Moscow"
        }
        
        
        
        let filteredData = downloadedData.filter() { $0.location.city == city };
        if filteredData.count != 0 {
            data = filteredData.first!
        }
        else {
            data = CurrentData(city: city)
            data.update()
            downloadedData.append(data)
        }
        
        cell.content = data
        
        return cell
    }
    
    //Вызываемая функция при нажатии на элемент списка
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alertController = UIAlertController(title: "Message", message:
            indexPath.row.description, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
