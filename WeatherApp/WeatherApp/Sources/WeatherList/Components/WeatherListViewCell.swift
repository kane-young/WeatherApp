//
//  WeatherListViewCell.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/23.
//

import UIKit

import RxSwift
import SnapKit

final class WeatherListViewCell: UITableViewCell {

  // MARK: Properties

  private let dateLabel = UILabel()
  private let logoImageView = UIImageView()
  private let weatherLabel = UILabel()
  private let maxTemperatureLabel = UILabel()
  private let minimumTemperatureLabel = UILabel()
  private var disposeBag = DisposeBag()
  private var viewModel: WeatherListCellViewModel?


  // MARK: Initializers

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.layout()
    self.attribute()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func layout() {
    [self.dateLabel,
     self.logoImageView,
     self.weatherLabel,
     self.maxTemperatureLabel,
     self.minimumTemperatureLabel].forEach {
      self.contentView.addSubview($0)
    }

    self.dateLabel.snp.makeConstraints {
      $0.leading.top.equalToSuperview().inset(10)
    }

    self.logoImageView.snp.makeConstraints {
      $0.leading.equalTo(self.dateLabel)
      $0.top.equalTo(self.dateLabel.snp.bottom).offset(10)
      $0.width.height.equalTo(50)
      $0.bottom.equalToSuperview().inset(10)
    }

    self.weatherLabel.snp.makeConstraints {
      $0.leading.equalTo(self.logoImageView.snp.trailing).offset(10)
      $0.bottom.equalTo(self.logoImageView)
    }

    self.minimumTemperatureLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(10)
      $0.centerY.equalTo(self.logoImageView)
    }

    self.maxTemperatureLabel.snp.makeConstraints {
      $0.trailing.equalTo(self.minimumTemperatureLabel.snp.leading).offset(-10)
      $0.centerY.equalTo(self.logoImageView)
    }
  }

  private func attribute() {
    self.setLabel(self.dateLabel, size: 17, textColor: .darkGray)
    self.setLabel(self.weatherLabel, size: 14, textColor: .darkGray)
    self.setLabel(self.minimumTemperatureLabel, size: 15, textColor: .darkGray)
    self.setLabel(self.maxTemperatureLabel, size: 15, textColor: .darkGray)
  }

  private func setLabel(_ label: UILabel, size: CGFloat, textColor: UIColor) {
    label.font = UIFont.systemFont(ofSize: size)
    label.textColor = textColor
  }

  override func prepareForReuse() {
    self.dateLabel.text = nil
    self.weatherLabel.text = nil
    self.maxTemperatureLabel.text = nil
    self.minimumTemperatureLabel.text = nil
    self.logoImageView.image = nil
    self.disposeBag = DisposeBag()
  }


  // MARK: Bind

  func bind(with viewModel: WeatherListCellViewModel) {
    self.viewModel = viewModel

    let output = viewModel.transform(input: WeatherListCellViewModel.Input())

    output.logoData
      .observe(on: MainScheduler.instance)
      .bind(onNext: { data in
        self.logoImageView.image = UIImage(data: data)
      }).disposed(by: self.disposeBag)

    output.error
      .observe(on: MainScheduler.instance)
      .bind { _ in
        self.logoImageView.image = UIImage(systemName: "xmark")
      }.disposed(by: self.disposeBag)

    self.setDateLabelText(with: viewModel.cellData)
    self.setWeatherLabelText(with: viewModel.cellData)
    self.setMaxTemperatureLabelText(with: viewModel.cellData)
    self.setMinimumTemperatureLabelText(with: viewModel.cellData)
  }

  private func setDateLabelText(with cellData: WeatherListViewCellData) {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    guard let date = formatter.date(from: cellData.dateText) else { return }
    formatter.dateFormat = "EEE d MMM"
    let dateLabelText = formatter.string(from: date)
    self.dateLabel.text = dateLabelText
  }

  private func setWeatherLabelText(with cellData: WeatherListViewCellData) {
    self.weatherLabel.text = cellData.weatherState.rawValue
  }

  private func setMaxTemperatureLabelText(with cellData: WeatherListViewCellData) {
    self.maxTemperatureLabel.text = "MAX : \(cellData.maxTemperature)℃"
  }

  private func setMinimumTemperatureLabelText(with cellData: WeatherListViewCellData) {
    self.minimumTemperatureLabel.text = "MIN : \(cellData.minTemperature)℃"
  }
}
