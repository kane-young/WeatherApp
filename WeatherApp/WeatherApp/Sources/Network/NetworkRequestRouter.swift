//
//  NetworkRequestRouter.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/22.
//

import Foundation

protocol URLRequestConvertible {
  func urlRequest() -> URLRequest?
}

enum NetworkRequestRouter: URLRequestConvertible {
  case fetchWeather(identifier: Int)
  case fetchWeatherLogo(state: WeatherState)

  private var baseURLString: String {
    return "https://www.metaweather.com"
  }

  private var httpMethod: HTTPMethod {
    return .get
  }

  private var path: String {
    switch self {
    case .fetchWeather(let identifier):
      return "/api/location/\(identifier)/"
    case .fetchWeatherLogo(let state):
      return "/static/img/weather/png/\(state.abbreviation).png"
    }
  }

  func urlRequest() -> URLRequest? {
    guard let url = URL(string: self.baseURLString + self.path) else { return nil }
    var request = URLRequest(url: url)
    request.httpMethod = self.httpMethod.rawValue
    return request
  }
}
