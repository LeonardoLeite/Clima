//
//  WeatherManager.swift
//  Clima
//
//  Created by Leonardo Leite on 22/10/20.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpadateWeather(_ weatherManager: WeatheManager, weather: WeatherModel)
    func didiFailWithError(error: Error)
}

struct WeatheManager {
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=2b2c83eff150c44105b7c9f3f79e801e&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(_ cityName: String) {
        let completeString = "\(weatherUrl)&q=\(cityName)"
        performRequest(with: completeString)
    }
    
    func fetchWeatherFrom(lat: String, lon: String) {
        let completeString = "\(weatherUrl)&lat=\(lat)&lon=\(lon)"
        performRequest(with: completeString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didiFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpadateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let speed = decodedData.wind.speed
            let deg = decodedData.wind.deg
            let sunrise = decodedData.sys.sunrise
            let sunset = decodedData.sys.sunset
            
            let feels_like = decodedData.main.feels_like
            let temp_min = decodedData.main.temp_min
            let temp_max = decodedData.main.temp_max
            let humidity = decodedData.main.humidity
            let pressure = decodedData.main.pressure
            
            let visibility = decodedData.visibility
            
            
            let weather = WeatherModel.init(conditionId: id, cityName: name, temperature: temp, speed: speed, deg: deg, sunrise: sunrise, sunset: sunset, feels_like: feels_like, temp_min: temp_min, temp_max: temp_max, humidity: humidity, pressure: pressure, visibility: visibility)
            return weather
        } catch {
            delegate?.didiFailWithError(error: error)
            return nil
        }
    }
}
