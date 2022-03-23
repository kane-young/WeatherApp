//
//  WeatherState.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/22.
//

import Foundation

enum WeatherState {
  case snow
  case sleet
  case hail
  case thunderStom
  case heavyRain
  case lightRain
  case showers
  case heavyCloud
  case lightCloud
  case clear

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
}
