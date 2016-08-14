//
//  CurrentWeather.swift
//  CoolWeather
//
//  Created by Vignesh Kumar on 8/11/16.
//  Copyright © 2016 Vignesh Kumar. All rights reserved.
//

import UIKit
import Alamofire


class CurrentWeather {
    
    private var _cityName: String!
    private var _date:String!
    private var _weatherType:String!
    private var _currentTemp:Int!
    
    
    var cityName:String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date:String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType:String {
        
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var currentTemp: Int {
        
        if _currentTemp == nil {
            
            _currentTemp = 0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        //Alamofire download
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        
        Alamofire.request(currentWeatherURL!, withMethod: .get).responseJSON { response in
            let result = response.result
            //print(response)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    
                    self._cityName = name.capitalized
                    print(self.cityName)
                    
                }
                
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        
                        self._weatherType = main.capitalized
                        print(self.weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String,AnyObject>{
                    
                    if let currentTemperature = main["temp"] as? Double {
                        
                        let kelvinToFarenheitPreDivision = (currentTemperature * (9/5) - 459.67)
                        
                        let kelvinToFarenheit = Int(round(10 * kelvinToFarenheitPreDivision/10))
                        
                        self._currentTemp = kelvinToFarenheit
                        
                        print(self.currentTemp)
                        
                    }
                }
            }
            completed()
        }
       
    
    }
    
    
    
}

