//
//  WeatherListCellViewModel.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/24.
//

import RxRelay
import RxSwift

final class WeatherListCellViewModel {

  // MARK: Properties

  let cellData: WeatherListViewCellData
  private let useCase: WeatherListCellUseCaseLogic
  private let disposeBag: DisposeBag


  // MARK: Initializers

  init(cellData: WeatherListViewCellData ,useCase: WeatherListCellUseCaseLogic = WeatherListCellUseCase()) {
    self.cellData = cellData
    self.useCase = useCase
    self.disposeBag = DisposeBag()
  }
}

extension WeatherListCellViewModel: ViewModelType {
  final class Input { }

  final class Output {
    let logoData = PublishRelay<Data>()
    let error = PublishRelay<Error>()
  }

  func transform(input: Input) -> Output {
    let output = Output()

    self.useCase.fetchWeatherLogo(with: self.cellData.weatherState)
      .subscribe { data in
        output.logoData.accept(data)
      } onFailure: { error in
        output.error.accept(error)
      }.disposed(by: self.disposeBag)

    return output
  }
}
