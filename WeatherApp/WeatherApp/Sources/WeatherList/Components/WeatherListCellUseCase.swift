//
//  WeatherListCellUseCase.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/24.
//

import RxSwift

protocol WeatherListCellUseCaseLogic {
  func fetchWeatherLogo(with state: WeatherState) -> Single<Data>
}

final class WeatherListCellUseCase: WeatherListCellUseCaseLogic {

  // MARK: Properties

  private let networkManager: NetworkManagerLogic


  // MARK: Initializers

  init(networkManager: NetworkManagerLogic = NetworkManager()) {
    self.networkManager = networkManager
  }

  func fetchWeatherLogo(with state: WeatherState) -> Single<Data> {
    return self.networkManager.fetchWeatherLogo(with: state)
  }
}
