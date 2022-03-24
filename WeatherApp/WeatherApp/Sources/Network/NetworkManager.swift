//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/22.
//

import Foundation

import RxSwift

protocol NetworkManagerLogic {
  func fetchLocationResponse(in city: City) -> Single<LocationResponse>
  func fetchWeatherLogo(with state: WeatherState) -> Single<Data>
}

final class NetworkManager: NetworkManagerLogic {
  private let urlSession: URLSession

  init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }

  func fetchLocationResponse(in city: City) -> Single<LocationResponse> {
    return self.fetchDecodedData(
      with: NetworkRequestRouter.fetchWeather(identifier: city.identifier),
      as: LocationResponse.self
    )
  }

  private func fetchDecodedData<T>(with router: NetworkRequestRouter, as type: T.Type) -> Single<T> where T: Decodable {
    return Single.create { observer -> Disposable in
      guard let request = router.urlRequest() else {
        observer(.failure(NetworkError.invalidURLRequest))
        return Disposables.create()
      }

      self.urlSession.dataTask(with: request) { data, response, error in
        if error != nil {
          observer(.failure(NetworkError.connectionProblem))
          return
        }

        if let response = response as? HTTPURLResponse,
           (200..<300).contains(response.statusCode) == false {
          observer(.failure(NetworkError.invalidStatusCode))
          return
        }

        guard let data = data else {
          observer(.failure(NetworkError.invalidData))
          return
        }

        guard let decodedData = try? JSONDecoder()
                .decode(type.self, from: data) else {
          observer(.failure(NetworkError.decodingError))
          return
        }

        observer(.success(decodedData))
      }.resume()

      return Disposables.create()
    }
  }

  func fetchWeatherLogo(with state: WeatherState) -> Single<Data> {
    let router = NetworkRequestRouter.fetchWeatherLogo(state: state)
    return fetchData(with: router)
  }

  private func fetchData(with router: NetworkRequestRouter) -> Single<Data> {
    return Single.create { observer -> Disposable in
      guard let request = router.urlRequest() else {
        observer(.failure(NetworkError.invalidURLRequest))
        return Disposables.create()
      }

      self.urlSession.dataTask(with: request) { data, response, error in
        if error != nil {
          observer(.failure(NetworkError.connectionProblem))
          return
        }

        if let response = response as? HTTPURLResponse,
           (200..<300).contains(response.statusCode) == false {
          observer(.failure(NetworkError.invalidStatusCode))
          return
        }

        guard let data = data else {
          observer(.failure(NetworkError.invalidData))
          return
        }

        observer(.success(data))
      }.resume()

      return Disposables.create()
    }
  }
}
