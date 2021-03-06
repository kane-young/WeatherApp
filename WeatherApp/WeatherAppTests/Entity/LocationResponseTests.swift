//
//  LocationResponseTests.swift
//  WeatherAppTests
//
//  Created by 이영우 on 2022/03/22.
//

import XCTest
@testable import WeatherApp

final class LocationResponseTests: XCTestCase {

  let sampleData = """
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
         },
         {
             "id": 4605531491663872,
             "weather_state_name": "Clear",
             "weather_state_abbr": "c",
             "wind_direction_compass": "WNW",
             "created": "2022-03-22T03:59:19.657398Z",
             "applicable_date": "2022-03-22",
             "min_temp": 10.115,
             "max_temp": 18.675,
             "the_temp": 16.7,
             "wind_speed": 5.434793464757814,
             "wind_direction": 292.5,
             "air_pressure": 1022.5,
             "humidity": 63,
             "visibility": 13.641272468782311,
             "predictability": 68
         },
         {
             "id": 5455332479336448,
             "weather_state_name": "Light Cloud",
             "weather_state_abbr": "lc",
             "wind_direction_compass": "W",
             "created": "2022-03-22T03:59:23.544141Z",
             "applicable_date": "2022-03-23",
             "min_temp": 10.600000000000001,
             "max_temp": 16.83,
             "the_temp": 17.43,
             "wind_speed": 6.042326598738036,
             "wind_direction": 272.21011785511337,
             "air_pressure": 1020.0,
             "humidity": 70,
             "visibility": 11.85389823431162,
             "predictability": 70
         },
         {
             "id": 5204519542587392,
             "weather_state_name": "Light Cloud",
             "weather_state_abbr": "lc",
             "wind_direction_compass": "W",
             "created": "2022-03-22T03:59:25.641889Z",
             "applicable_date": "2022-03-24",
             "min_temp": 9.559999999999999,
             "max_temp": 13.51,
             "the_temp": 15.495000000000001,
             "wind_speed": 6.371335327850685,
             "wind_direction": 269.3993812382196,
             "air_pressure": 1020.0,
             "humidity": 75,
             "visibility": 13.890442316869482,
             "predictability": 70
         },
         {
             "id": 6601853363027968,
             "weather_state_name": "Light Cloud",
             "weather_state_abbr": "lc",
             "wind_direction_compass": "W",
             "created": "2022-03-22T03:59:28.643872Z",
             "applicable_date": "2022-03-25",
             "min_temp": 8.975,
             "max_temp": 14.57,
             "the_temp": 15.120000000000001,
             "wind_speed": 5.77229254692065,
             "wind_direction": 273.47401744399787,
             "air_pressure": 1017.0,
             "humidity": 71,
             "visibility": 13.897588085580212,
             "predictability": 70
         },
         {
             "id": 6330419449430016,
             "weather_state_name": "Heavy Cloud",
             "weather_state_abbr": "hc",
             "wind_direction_compass": "W",
             "created": "2022-03-22T03:59:31.582151Z",
             "applicable_date": "2022-03-26",
             "min_temp": 9.39,
             "max_temp": 13.915,
             "the_temp": 14.31,
             "wind_speed": 6.090466276942655,
             "wind_direction": 270.0,
             "air_pressure": 1017.0,
             "humidity": 72,
             "visibility": 9.999726596675416,
             "predictability": 71
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
         },
         {
             "title": "Forecast.io",
             "slug": "forecast-io",
             "url": "http://forecast.io/",
             "crawl_rate": 480
         },
         {
             "title": "HAMweather",
             "slug": "hamweather",
             "url": "http://www.hamweather.com/",
             "crawl_rate": 360
         },
         {
             "title": "Met Office",
             "slug": "met-office",
             "url": "http://www.metoffice.gov.uk/",
             "crawl_rate": 180
         },
         {
             "title": "OpenWeatherMap",
             "slug": "openweathermap",
             "url": "http://openweathermap.org/",
             "crawl_rate": 360
         },
         {
             "title": "Weather Underground",
             "slug": "wunderground",
             "url": "https://www.wunderground.com/?apiref=fc30dc3cd224e19b",
             "crawl_rate": 720
         },
         {
             "title": "World Weather Online",
             "slug": "world-weather-online",
             "url": "http://www.worldweatheronline.com/",
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

  func test_LocationResponse_decoding_테스트() throws {
    //given
    let decoder = JSONDecoder()
    //when
    let data = try? decoder.decode(LocationResponse.self, from: sampleData)
    //then
    XCTAssertNotNil(data)
  }
}
