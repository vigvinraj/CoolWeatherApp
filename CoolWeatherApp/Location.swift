//
//  Location.swift
//  CoolWeatherApp
//
//  Created by Vignesh Kumar on 8/21/16.
//  Copyright © 2016 Vignesh Kumar. All rights reserved.
//

import CoreLocation


class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude:Double!
    var longitude:Double!
    var CURRENT_WEATHER_URL:String!
    var FORECAST_WEATHER_URL:String!

}
