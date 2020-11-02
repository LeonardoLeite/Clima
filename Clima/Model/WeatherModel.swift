//
//  WeatherModel.swift
//  Clima
//
//  Created by Leonardo Leite on 22/10/20.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let speed: Double
    let deg: Int
    let sunrise: Int
    let sunset: Int
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
    let pressure: Int
    let visibility: Int
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String{
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var windAngle: String {
        switch deg {
        case 0...22:
            return "arrow.up.square"
        case 338...360:
            return "arrow.up.square"
        case 23...67:
            return "arrow.up.right.square"
        case 68...112:
            return "arrow.forward.square"
        case 113...157:
            return "arrow.down.forward.square"
        case 157...202:
            return "arrow.down.square"
        case 203...247:
            return "arrow.down.backward.square"
        case 248...292:
            return "arrow.backward.square"
        case 293...337:
            return "arrow.up.backward.square"
        default:
            return "questionmark.square.dashed"
        }
    }
    
    var windShortName: String {
        switch deg {
        case 0...22:
            return "N"
        case 338...360:
            return "N"
        case 23...67:
            return "NE"
        case 68...112:
            return "E"
        case 113...157:
            return "SE"
        case 157...202:
            return "S"
        case 203...247:
            return "SW"
        case 248...292:
            return "W"
        case 293...337:
            return "NW"
        default:
            return "?"
        }
    }
    
    var sunriseFormated: String {
        let dateDouble = Double(sunrise)
        let date = Date(timeIntervalSince1970: dateDouble)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    var sunsetFormated: String {
        let dateDouble = Double(sunset)
        let date = Date(timeIntervalSince1970: dateDouble)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
}
