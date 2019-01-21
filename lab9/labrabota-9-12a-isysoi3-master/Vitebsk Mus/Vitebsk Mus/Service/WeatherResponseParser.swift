//
//  WeatherResponseParser.swift
//  Vitebsk Mus
//
//  Created by Ilya Sysoi on 5/6/18.
//  Copyright © 2018 isysoi. All rights reserved.
//

import Foundation
import SwiftyJSON
import Result

enum ParserWeatherResponseErrorEnum: Error {
    case invlaidSchema
}

class WeatherResponseParser {
    
    func parseWeatherInfo(json: JSON) -> Result<String,ParserWeatherResponseErrorEnum> {
        print(json)
        if let tempr = json["query"]["results"]["channel"]["item"]["condition"]["temp"].string {
            return .success(tempr)
        }
        return .failure(.invlaidSchema)
        
        
    }
    
}
