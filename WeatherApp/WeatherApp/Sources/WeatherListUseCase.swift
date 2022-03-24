//
//  WeatherListUseCase.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/24.
//

import RxSwift

protocol WeatherListUseCaseLogic {
  func fetchLocationResponse(with city: City) -> Single<LocationResponse>
  func weatherListSections(with response: LocationResponse) -> [WeatherListSection]
}

final class WeatherListUseCase: WeatherListUseCaseLogic {

  // MARK: Properties

  private let networkManager: NetworkManagerLogic


  // MARK: Initializers

  init(networkManager: NetworkManagerLogic = NetworkManager()) {
    self.networkManager = networkManager
  }

  func fetchLocationResponse(with city: City) -> Single<LocationResponse> {
    return networkManager.fetchLocationResponse(in: city)
  }

  func weatherListSections(with response: LocationResponse) -> [WeatherListSection] {
    let items = response.consolidatedWeather.map {
      WeatherListViewCellData(
        dateText: $0.applicableDate,
        weatherState: WeatherState.search(with: $0.weatherStateName),
        maxTemperature: Int($0.maxTemp),
        minTemperature: Int($0.minTemp)
      )
    }
    return [
      WeatherListSection(
        header: response.title,
        items: items
      )
    ]
  }
}
