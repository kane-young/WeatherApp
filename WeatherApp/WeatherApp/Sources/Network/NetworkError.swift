//
//  NetworkError.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/22.
//

import Foundation

enum NetworkError: Error {
  case invalidURLRequest
  case connectionProblem
  case invalidStatusCode
  case invalidData
  case decodingError
}
