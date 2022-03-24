//
//  WeatherState.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/22.
//

import Foundation

enum WeatherState: String, CaseIterable {
  case snow = "Snow"
  case sleet = "Sleet"
  case hail = "Hail"
  case thunderStom = "Thunder Stom"
  case heavyRain = "Heavy Rain"
  case lightRain = "Light Rain"
  case showers = "Showers"
  case heavyCloud = "Heavy Cloud"
  case lightCloud = "Light Cloud"
  case clear = "Clear"

  var abbreviation: String {
    switch self {
    case .snow:
      return "sn"
    case .sleet:
      return "sl"
    case .hail:
      return "h"
    case .thunderStom:
      return "t"
    case .heavyRain:
      return "hr"
    case .lightRain:
      return "lr"
    case .showers:
      return "s"
    case .heavyCloud:
      return "hc"
    case .lightCloud:
      return "lc"
    case .clear:
      return "c"
    }
  }

  static func search(with text: String) -> WeatherState {
    for weatherState in WeatherState.allCases {
      if weatherState.rawValue == text {
        return weatherState
      }
    }
    return .clear
  }
}
