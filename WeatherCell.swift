//
//  WeatherCell.swift
//  MyWeatherApp
//
//  Created by Faannaka on 30.03.16.
//  Copyright © 2016 Faannaka. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel : UILabel!
    @IBOutlet weak var countryLabel : UILabel!
    @IBOutlet weak var temperatureLabel : UILabel!
    @IBOutlet weak var background : UIImageView!
    
    var content : CurrentData! {
        didSet {
            if content.location.city != nil {
                cityLabel.text = content.location.city
            }
            else {
                cityLabel.text = "n/a"
            }
            
            if content.location.country != nil {
                if countries[content.location.country!] != nil {
                    countryLabel.text = countries[content.location.country!]
                }
                else {
                    countryLabel.text = content.location.country
                }
            }
            else {
                countryLabel.text = "n/a"
            }
            
            if content.weather.temperature != nil {
                temperatureLabel.text = Int(content.weather.temperature!).description + "˚"
            }
            else {
                temperatureLabel.text = "n/a"
            }
            
            background.layer.cornerRadius = 5
            background.layer.masksToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
