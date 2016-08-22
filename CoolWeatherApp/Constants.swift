//
//  Constants.swift
//  CoolWeather
//
//  Created by Vignesh Kumar on 8/11/16.
//  Copyright © 2016 Vignesh Kumar. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/"
let CURRENT_WEATHER = "weather?"
let FORECAST_WEATHER = "forecast/daily?"
let NUMBER_OF_DAYS = "&cnt=6"
let MODE = "&mode=json"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "31b66328ad18dc8c9695260b6be951e4"

typealias DownloadComplete = () -> ()

//var CURRENT_WEATHER_URL = "\(BASE_URL)\(CURRENT_WEATHER)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"

//var FORECAST_WEATHER_URL = "\(BASE_URL)\(FORECAST_WEATHER)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(NUMBER_OF_DAYS)\(MODE)\(APP_ID)\(API_KEY)"

