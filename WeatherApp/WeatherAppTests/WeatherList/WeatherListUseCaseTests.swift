//
//  WeatherListUseCaseTests.swift
//  WeatherAppTests
//
//  Created by 이영우 on 2022/03/24.
//

import XCTest
@testable import WeatherApp

import Nimble
import RxSwift

final class WeatherListUseCaseTests: XCTestCase {

  var sut: WeatherListUseCaseLogic!

  override func setUp() {
    self.sut = WeatherListUseCase()
  }
  
  override func tearDown() {
    self.sut = nil
  }

  func test_LocationResponse를_WeatherListSection으로_변환() {
    //given
    let locationResponse = LocationResponse(
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
    let expectedListSection = WeatherListSection(
      header: "San Francisco",
      items: [
        WeatherListSection.Item(
          dateText: "2022-03-21",
          weatherState: .lightCloud,
          maxTemperature: 17,
          minTemperature: 9
        )
      ]
    )

    //when
    let weatherListSection = self.sut.weatherListSections(with: locationResponse)

    //then
    expect(weatherListSection).to(equal([expectedListSection]))
  }
}
