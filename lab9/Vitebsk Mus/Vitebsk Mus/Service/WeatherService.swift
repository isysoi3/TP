//
//  WeatherService.swift
//  Vitebsk Mus
//
//  Created by Ilya Sysoi on 5/6/18.
//  Copyright © 2018 isysoi. All rights reserved.
//

import Foundation
import Alamofire
import enum Result.Result
import SwiftyJSON

enum WeatherServiceErrorEnum: Error {
    case parseError
    case invalidConnection
}

class WeatherService {
    
    
    func getWheatherForCity(_ city: String,
                            completionBlock: @escaping (Result<String, WeatherServiceErrorEnum>) -> () ) {
        
        let baseUrl = "https://query.yahooapis.com/v1/public/yql"
        let params: [String : String]
            = ["q" : "select item.condition from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"\(city)\")",
                "format" : "json"]
        
        Alamofire
            .request(baseUrl, method: .get, parameters: params)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let parser = WeatherResponseParser()
                    let parsingResult = parser.parseWeatherInfo(json: JSON(value))
                    
                    switch parsingResult {
                    case .success(let value):
                        completionBlock(.success(value))
                    case .failure:
                        completionBlock(.failure(.parseError))
                    }
                    
                case .failure:
                    completionBlock(.failure(.invalidConnection))
                }
               
            
        }
    }
    
}
