//
//  Api.swift
//  MyWeatherApp
//
//  Created by Faannaka on 26.03.16.
//  Copyright © 2016 Faannaka. All rights reserved.
//

import Foundation

struct Coordinates {
    var longitude : Double?
    var latitude : Double?
}

struct Weather {
    var temperature : Double?
    var pressure : Double?
    var humidity : Double?
    var minimalTemperature : Double?
    var maxmimalTemperature : Double?
    var windSpeed : Double?
    var sunrise : NSDate?
    var sunset : NSDate?
}

struct Location {
    var country : String?
    var city : String?
    var id: Int?
}

class CurrentData {
    let key = ""
    
    var coordinates : Coordinates = Coordinates()
    var weather : Weather = Weather()
    var location : Location = Location()
    
    var updated : Bool = false
    
    init(city : String) {
        self.location.city = city
    }
    
    func update() {
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(self.location.city!.stringByReplacingOccurrencesOfString(" ", withString: "%20"))&units=metric&appid=\(self.key)"
        if let responce = NSData(contentsOfURL: NSURL(string: url)!) {
            if let json = try? NSJSONSerialization.JSONObjectWithData(responce, options: .AllowFragments) {
                //Update city name
                if !self.updated {
                    if let city = json["name"] as? String {
                        self.location.city = city
                    }
                    if let id = json["id"] as? Int {
                        self.location.id = id
                    }
                }
                
                //Update weather
                if let main = json["main"] as? [String : AnyObject] {
                    if let temp = main["temp"] as? Double {
                        self.weather.temperature = temp
                    }
                    if let pressure = main["pressure"] as? Double {
                        self.weather.pressure = pressure
                    }
                    if let humidity = main["humidity"] as? Double {
                        self.weather.humidity = humidity
                    }
                    if let minTemp = main["temp_min"] as? Double {
                        self.weather.minimalTemperature = minTemp
                    }
                    if let maxTemp = main["temp_max"] as? Double {
                        self.weather.maxmimalTemperature = maxTemp
                    }
                }
                //Update wind speed
                if let wind = json["wind"] as? [String : AnyObject] {
                    if let speed = wind["speed"] as? Double {
                        self.weather.windSpeed = speed
                    }
                }
                //Update location & sunrise & sunset
                if let sys = json["sys"] as? [String : AnyObject] {
                    if !self.updated {
                        if let country = sys["country"] as? String {
                            self.location.country = country
                        }
                    }
                    if let sunrise = sys["sunrise"] as? Double {
                        self.weather.sunrise = NSDate(timeIntervalSince1970: sunrise)
                    }
                    if let sunset = sys["sunset"] as? Double {
                        self.weather.sunset = NSDate(timeIntervalSince1970: sunset)
                    }
                }
                //Update coordinates
                if !self.updated {
                    if let coord = json["coord"] as? [String : AnyObject] {
                        if let lon = coord["lon"] as? Double {
                            self.coordinates.longitude = lon
                        }
                        if let lat = coord["lat"] as? Double {
                            self.coordinates.latitude = lat
                        }
                    }
                }
            }
        }
        
        self.updated = true
    }
}