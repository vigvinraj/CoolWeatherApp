//
//  ViewController.swift
//  CoolWeatherApp
//
//  Created by Vignesh Kumar on 8/21/16.
//  Copyright © 2016 Vignesh Kumar. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast:Forecast!
    var forecasts = [Forecast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
        currentWeather = CurrentWeather()
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if currentLocation.coordinate.latitude != locationManager.location?.coordinate.latitude && currentLocation.coordinate.longitude != locationManager.location?.coordinate.longitude {
            print(locationManager.location)
            currentLocation = locationManager.location
            forecasts.removeAll()
            locationAuthStatus()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print(Location.sharedInstance.longitude,Location.sharedInstance.latitude)
            print(currentLocation.coordinate.latitude,currentLocation.coordinate.longitude)
            
            Location.sharedInstance.CURRENT_WEATHER_URL = "\(BASE_URL)\(CURRENT_WEATHER)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"
            Location.sharedInstance.FORECAST_WEATHER_URL = "\(BASE_URL)\(FORECAST_WEATHER)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(NUMBER_OF_DAYS)\(MODE)\(APP_ID)\(API_KEY)"
            print(Location.sharedInstance.CURRENT_WEATHER_URL)
            print(Location.sharedInstance.FORECAST_WEATHER_URL)
            currentWeather.downloadWeatherDetails {
                self.forecasts.removeAll()
                self.downloadForecastData {
                    self.updateMainUI()
                }
                
            }
            
            
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: DownloadComplete) {
        //Downloading forecast weather data for TableView
        let forecastURL = NSURL(string: Location.sharedInstance.FORECAST_WEATHER_URL)!
        Alamofire.request(.GET, forecastURL).responseJSON { response in
            
            let result = response.result
            print(result.value)
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let list = dict["list"] as? [Dictionary<String,AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.forecasts.removeAtIndex(0)
                    self.tableView.reloadData()
                }
            }
            completed()
            
        }
        
    }
    
    

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("weatherCell", forIndexPath: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast)
            return cell
            
        } else {
            
            return WeatherCell()
        }

    }

    func updateMainUI(){
        print(currentWeather.date,currentWeather.currentTemp,currentWeather.weatherType,currentWeather.cityName)
        dateLbl.text = currentWeather.date
        currentTempLbl.text = "\(currentWeather.currentTemp)°"
        currentWeatherTypeLbl.text = currentWeather.weatherType
        locationLbl.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
}


