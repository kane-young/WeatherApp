//
//  City.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/22.
//

import Foundation

enum City {
  case seoul
  case london
  case chicago

  var identifier: Int {
    switch self {
    case .seoul:
      return 1132599
    case .london:
      return 44418
    case .chicago:
      return 2379574
    }
  }
}
