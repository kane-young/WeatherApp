//
//  NetworkManagerTests.swift
//  WeatherAppTests
//
//  Created by 이영우 on 2022/03/22.
//

import XCTest
@testable import WeatherApp

import Nimble
import RxSwift

final class NetworkManagerTests: XCTestCase {

  private var sut: NetworkManager!
  private var disposeBag: DisposeBag!
  private var expectation: XCTestExpectation!

  override func setUp() {
    let configuration = URLSessionConfiguration.default
    configuration.protocolClasses = [MockURLProtocol.self]
    let mockURLSession = URLSession(configuration: configuration)
    self.sut = NetworkManager(urlSession: mockURLSession)
    self.disposeBag = DisposeBag()
    self.expectation = XCTestExpectation()
  }

  override func tearDown() {
    self.disposeBag = DisposeBag()
    self.expectation = nil
  }

  func test_fetchLocationResponse_404에러발생하면_invalidStatusCode_발생() {
    //given
    let expectedError = NetworkError.invalidStatusCode
    let dummyURL = URL(string: "https://www.weatherapp.com")!
    MockURLProtocol.requestHandler = { _ in
        let response = HTTPURLResponse(url: dummyURL, statusCode: 404, httpVersion: nil, headerFields: nil)
        return (response, nil, nil)
    }

    //when
    self.sut.fetchLocationResponse(in: .seoul)
      .subscribe { _ in
        XCTFail()
      } onFailure: { error in
        //then
        guard let error = error as? NetworkError else { return }
        expect(error).to(equal(expectedError))
        self.expectation.fulfill()
      }.disposed(by: self.disposeBag)

    wait(for: [expectation], timeout: 2.0)
  }

  func test_fetchLocationResponse_error존재하면_connectionProblem_발생() {
    //given
    let expectedError = NetworkError.connectionProblem
    let dummyURL = URL(string: "https://www.weatherapp.com")!
    MockURLProtocol.requestHandler = { _ in
      let response = HTTPURLResponse(url: dummyURL, statusCode: 200, httpVersion: nil, headerFields: nil)
      return (response, Data(), NetworkError.connectionProblem)
    }

    //when
    self.sut.fetchLocationResponse(in: .seoul)
      .subscribe { _ in
        XCTFail()
      } onFailure: { error in
        //then
        guard let error = error as? NetworkError else { return }
        expect(error).to(equal(expectedError))
        self.expectation.fulfill()
      }.disposed(by: self.disposeBag)

    wait(for: [expectation], timeout: 2.0)
  }

  func test_fetchLocationResponse_Entity와_다른_JSONData일_경우_decodingError_발생() {
    //given
    let expectedError = NetworkError.decodingError
    let dummyURL = URL(string: "https://www.weatherapp.com")!
    let strangeData = "".data(using: .utf8)
    MockURLProtocol.requestHandler = { _ in
      let response = HTTPURLResponse(url: dummyURL, statusCode: 200, httpVersion: nil, headerFields: nil)
      return (response, strangeData, nil)
    }

    //when
    self.sut.fetchLocationResponse(in: .seoul)
      .subscribe { _ in
        XCTFail()
      } onFailure: { error in
        //then
        guard let error = error as? NetworkError else { return }
        expect(error).to(equal(expectedError))
        self.expectation.fulfill()
      }.disposed(by: self.disposeBag)

    wait(for: [expectation], timeout: 2.0)
  }

  func test_fetchLocationResponse_정상작동_확인() {
    //given
    let dummyURL = URL(string: "https://www.weatherapp.com")!
    let expectedData = """
 {
     "consolidated_weather": [
         {
             "id": 5521165738049536,
             "weather_state_name": "Light Cloud",
             "weather_state_abbr": "lc",
             "wind_direction_compass": "W",
             "created": "2022-03-22T03:59:16.684298Z",
             "applicable_date": "2022-03-21",
             "min_temp": 9.22,
             "max_temp": 17.315,
             "the_temp": 20.045,
             "wind_speed": 4.791600998091147,
             "wind_direction": 280.0,
             "air_pressure": 1022.5,
             "humidity": 57,
             "visibility": 12.702380597311699,
             "predictability": 70
         }
     ],
     "time": "2022-03-21T22:36:02.466833-07:00",
     "sun_rise": "2022-03-21T07:11:27.021972-07:00",
     "sun_set": "2022-03-21T19:21:45.170220-07:00",
     "timezone_name": "LMT",
     "parent": {
         "title": "California",
         "location_type": "Region / State / Province",
         "woeid": 2347563,
         "latt_long": "37.271881,-119.270233"
     },
     "sources": [
         {
             "title": "BBC",
             "slug": "bbc",
             "url": "http://www.bbc.co.uk/weather/",
             "crawl_rate": 360
         }
     ],
     "title": "San Francisco",
     "location_type": "City",
     "woeid": 2487956,
     "latt_long": "37.777119, -122.41964",
     "timezone": "US/Pacific"
 }
""".data(using: .utf8)!
    MockURLProtocol.requestHandler = { _ in
      let response = HTTPURLResponse(url: dummyURL, statusCode: 200, httpVersion: nil, headerFields: nil)
      return (response, expectedData, nil)
    }
    let expectedLocationResponse = LocationResponse(
      consolidatedWeather: [WeatherResponse(
        id: 5521165738049536,
        weatherStateName: "Light Cloud",
        weatherStateAbbr: "lc",
        windDirectionCompass: "W",
        created: "2022-03-22T03:59:16.684298Z",
        applicableDate: "2022-03-21",
        minTemp: 9.22,
        maxTemp: 17.315,
        theTemp: 20.045,
        windSpeed: 4.791600998091147,
        windDirection: 280.0,
        airPressure: 1022.5,
        humidity: 57,
        visibility: 12.702380597311699,
        predictability: 70
      )],
      time: "2022-03-21T22:36:02.466833-07:00",
      sunRise: "2022-03-21T07:11:27.021972-07:00",
      sunSet: "2022-03-21T19:21:45.170220-07:00",
      timezoneName: "LMT",
      parent: CitySearchResponse(
        title: "California",
        locationType: "Region / State / Province",
        woeid: 2347563,
        lattLong: "37.271881,-119.270233"
      ),
      sources: [SourceResponse(
        title: "BBC",
        slug: "bbc",
        url: "http://www.bbc.co.uk/weather/",
        crawlRate: 360
      )],
      title: "San Francisco",
      locationType: "City",
      woeid: 2487956,
      lattLong: "37.777119, -122.41964",
      timezone: "US/Pacific"
    )

    //when
    self.sut.fetchLocationResponse(in: .seoul)
      .subscribe { response in
        //then
        expect(response).to(equal(expectedLocationResponse))
        self.expectation.fulfill()
      } onFailure: { _ in
        XCTFail()
      }.disposed(by: self.disposeBag)

    wait(for: [expectation], timeout: 2.0)
  }

  func test_fetchWeatherLogo_404에러발생하면_invalidStatusCode_발생() {
    //given
    let expectedError = NetworkError.invalidStatusCode
    let dummyURL = URL(string: "https://www.weatherapp.com")!
    MockURLProtocol.requestHandler = { _ in
        let response = HTTPURLResponse(url: dummyURL, statusCode: 404, httpVersion: nil, headerFields: nil)
        return (response, nil, nil)
    }

    //when
    self.sut.fetchWeatherLogo(with: .clear)
      .subscribe { _ in
        XCTFail()
      } onFailure: { error in
        //then
        guard let error = error as? NetworkError else { return }
        expect(error).to(equal(expectedError))
        self.expectation.fulfill()
      }.disposed(by: self.disposeBag)

    wait(for: [expectation], timeout: 2.0)
  }

  func test_fetchWeatherLogo_error존재하면_connectionProblem_발생() {
    //given
    let expectedError = NetworkError.connectionProblem
    let dummyURL = URL(string: "https://www.weatherapp.com")!
    MockURLProtocol.requestHandler = { _ in
      let response = HTTPURLResponse(url: dummyURL, statusCode: 200, httpVersion: nil, headerFields: nil)
      return (response, Data(), NetworkError.connectionProblem)
    }

    //when
    self.sut.fetchWeatherLogo(with: .clear)
      .subscribe { _ in
        XCTFail()
      } onFailure: { error in
        //then
        guard let error = error as? NetworkError else { return }
        expect(error).to(equal(expectedError))
        self.expectation.fulfill()
      }.disposed(by: self.disposeBag)

    wait(for: [expectation], timeout: 2.0)
  }

  func test_fetchWeatherLogo_정상작동_확인() {
    //given
    let dummyURL = URL(string: "https://www.weatherapp.com")!
    let expectedData = Data()
    MockURLProtocol.requestHandler = { _ in
      let response = HTTPURLResponse(url: dummyURL, statusCode: 200, httpVersion: nil, headerFields: nil)
      return (response, expectedData, nil)
    }

    //when
    self.sut.fetchWeatherLogo(with: .clear)
      .subscribe { response in
        //then
        expect(response).to(equal(expectedData))
        self.expectation.fulfill()
      } onFailure: { _ in
        XCTFail()
      }.disposed(by: self.disposeBag)

    wait(for: [expectation], timeout: 2.0)
  }
}
