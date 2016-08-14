//
//  Forecast.swift
//  CoolWeatherApp
//
//  Created by Vignesh Kumar on 8/13/16.
//  Copyright © 2016 Vignesh Kumar. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    private var _date: String!
    private var _weatherType:String!
    private var _highTemp:Int!
    private var _lowTemp:Int!
    
    
    
    var date:String {
        
        if _date == nil {
            _date = ""
        }
        
        return _date
    }
    
    var weatherType:String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var highTemp:Int {
        if _highTemp == nil {
            _highTemp = 0
        }
        return _highTemp
    }
    
    var lowTemp:Int {
        if _lowTemp == nil {
            _lowTemp = 0
        }
        
        return _lowTemp
    }
    
    init(weatherDict:Dictionary<String,AnyObject>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String,AnyObject> {
            if let min = temp["min"] as? Double {
                
                let kelvinToFarenheitPreDivision = (min * (9/5) - 459.67)
                
                let kelvinToFarenheit = Int(round(10 * kelvinToFarenheitPreDivision/10))
                
                self._lowTemp = kelvinToFarenheit
            }
            
            if let max = temp["max"] as? Double {
                
                let kelvinToFarenheitPreDivision = (max * (9/5) - 459.67)
                
                let kelvinToFarenheit = Int(round(10 * kelvinToFarenheitPreDivision/10))
                
                self._highTemp = kelvinToFarenheit
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String,AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
    
}


extension Date {
    
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from:self)
    }
}
