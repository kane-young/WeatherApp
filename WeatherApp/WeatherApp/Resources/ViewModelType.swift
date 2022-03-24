//
//  ViewModelType.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/24.
//

import Foundation

protocol ViewModelType {
  associatedtype Input
  associatedtype Output

  func transform(input: Input) -> Output
}
