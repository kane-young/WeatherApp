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
}

final class NetworkManager: NetworkManagerLogic {
  private let urlSession: URLSession

  init(urlSession: URLSession) {
    self.urlSession = urlSession
  }

  func fetchLocationResponse(in city: City) -> Single<LocationResponse> {
    return Single.create { observer -> Disposable in
      guard let request = NetworkRequestRouter.fetchWeather(identifier: city.identifier).urlRequest() else {
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

        guard let locationResponse = try? JSONDecoder()
                .decode(LocationResponse.self, from: data) else {
          observer(.failure(NetworkError.decodingError))
          return
        }

        observer(.success(locationResponse))
      }.resume()

      return Disposables.create()
    }
  }
}
