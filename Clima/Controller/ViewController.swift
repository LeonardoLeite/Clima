//
//  ViewController.swift
//  Clima
//
//  Created by Leonardo Leite on 22/10/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var windDirectionImageView: UIImageView!
    @IBOutlet weak var windVelocityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var maxMinLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!

    var weatherManager = WeatheManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }

    @IBAction func searchButton(_ sender: UIButton) {
        self.searchTextField.endEditing(true)
    }
}

//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            self.weatherManager.fetchWeather(searchTextField.text!)
            return true
        } else {
            searchTextField.text = "Type something here!"
            return false
        }
    }
}

//MARK: - WeatherManagerDelegate
extension ViewController: WeatherManagerDelegate {
    func didUpadateWeather(_ weatherManager: WeatheManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherImageView.image = UIImage(systemName: weather.conditionName)
            self.temperatureLabel.text = "\(weather.temperatureString)ºC"
            self.cityNameLabel.text = weather.cityName
            self.windDirectionImageView.image = UIImage(systemName: weather.windAngle)
            self.windVelocityLabel.text = "\(weather.speed)m/s\n\(weather.windShortName)"
            self.sunriseLabel.text = weather.sunriseFormated
            self.sunsetLabel.text = weather.sunsetFormated
            self.feelsLikeLabel.text = "\(weather.feels_like)ºC"
            self.maxMinLabel.text = "\(weather.temp_min)/\(weather.temp_max)ºC"
            self.humidityLabel.text = "\(weather.humidity)%"
            self.pressureLabel.text = "\(weather.pressure)hPa"
            self.visibilityLabel.text = "\(weather.visibility)m"
        }
    }
    
    func didiFailWithError(error: Error) {
        print(error)
    }
}

extension ViewController: CLLocationManagerDelegate {
    @IBAction func getGpsLocationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = "\(location.coordinate.latitude)"
            let lon = "\(location.coordinate.longitude)"
            
            weatherManager.fetchWeatherFrom(lat: lat, lon: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

