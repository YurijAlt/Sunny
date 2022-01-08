//
//  NetworkManager.swift
//  Sunny
//
//  Created by Юрий Альт on 08.01.2022.
//  Copyright © 2022 Ivan Akulov. All rights reserved.
//

import Foundation


struct NetworkManager {
    func fetchCurrentWeather(forCity city: String) {
        let api = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        
        guard let url = URL(string: api) else { return }

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                let currentWeather = parseJSON(withData: data)
            }
        }
        task.resume()
    }
    
    
    func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
