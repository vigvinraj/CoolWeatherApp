//
//  Constants.swift
//  CoolWeatherApp
//
//  Created by Vignesh Kumar on 8/21/16.
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
let API_KEY = "07ee4a40f4292a05f73ab5bd156277ed"

typealias DownloadComplete = () -> ()

//let CURRENT_WEATHER_URL = "\(BASE_URL)\(CURRENT_WEATHER)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"
//
//let FORECAST_WEATHER_URL = "\(BASE_URL)\(FORECAST_WEATHER)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(NUMBER_OF_DAYS)\(MODE)\(APP_ID)\(API_KEY)"

