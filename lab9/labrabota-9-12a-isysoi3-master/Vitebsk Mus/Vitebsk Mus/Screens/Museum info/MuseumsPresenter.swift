//
//  MuseumsPresenter.swift
//  Vitebsk Mus
//
//  Created by Ilya Sysoi on 5/6/18.
//  Copyright © 2018 isysoi. All rights reserved.
//

import Foundation

class MuseumsPresenter {
    private var service: WeatherService!
    private var view: MuseumsViewProtocol!
    
    func onViewDidLoad(view: MuseumsViewProtocol, city: String) {
        service = WeatherService()
        self.view = view
        
        sendWeatherRequestForCity(city)
    }
    
    private func sendWeatherRequestForCity(_ city: String) {
        view.setActivityIndicator(isVisible: true)
        
        service.getWheatherForCity(city) { [weak self] data in
            self?.view.setActivityIndicator(isVisible: false)
            switch data {
            case .success(let value) :
                self?.view.setWeatherInfo(temp: value)
            case .failure:
                break
            }
        }
    }
}
