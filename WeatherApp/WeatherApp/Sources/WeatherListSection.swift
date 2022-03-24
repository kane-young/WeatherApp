//
//  WeatherListSection.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/24.
//

import RxDataSources

struct WeatherListSection {
  var header: String
  var items: [Item]
}

extension WeatherListSection: SectionModelType {
  typealias Item = WeatherListViewCellData

  init(original: WeatherListSection, items: [WeatherListViewCellData]) {
    self = original
    self.items = items
  }
}
