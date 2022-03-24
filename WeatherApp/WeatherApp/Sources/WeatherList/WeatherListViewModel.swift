//
//  WeatherListViewModel.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/24.
//

import RxRelay
import RxSwift

final class WeatherListViewModel {

  // MARK: Properties

  private let useCase: WeatherListUseCaseLogic
  private let disposeBag: DisposeBag


  // MARK: Initializers

  init(useCase: WeatherListUseCaseLogic = WeatherListUseCase()) {
    self.useCase = useCase
    self.disposeBag = DisposeBag()
  }
}

extension WeatherListViewModel: ViewModelType {
  final class Input { }

  final class Output {
    let weatherListSection = PublishRelay<[WeatherListSection]>()
    let error = PublishRelay<Error>()
  }

  func transform(input: Input) -> Output {
    let output = Output()

    Observable.from([City.seoul, City.london, City.chicago])
      .flatMap {
        return self.useCase.fetchLocationResponse(with: $0)
      }.map(self.useCase.weatherListSections)
      .scan([], accumulator: { section, sectionToUpdate in
        (section + sectionToUpdate).sorted(by: { $0.header > $1.header })
      })
      .subscribe { weatherListSection in
        output.weatherListSection.accept(weatherListSection)
      }onError: { error in
        output.error.accept(error)
      }.disposed(by: self.disposeBag)

    return output
  }
}

