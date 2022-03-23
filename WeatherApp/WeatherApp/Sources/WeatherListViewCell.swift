//
//  WeatherListViewCell.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/23.
//

import UIKit

import SnapKit

final class WeatherListViewCell: UITableViewCell {

  // MARK: Properties

  private let dateLabel = UILabel()
  private let logoImageView = UIImageView()
  private let weatherLabel = UILabel()
  private let maxTemperatureLabel = UILabel()
  private let minimumTemperatureLabel = UILabel()


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
    self.setLabel(self.maxTemperatureLabel, size: 14, textColor: .darkGray)
    self.setLabel(self.minimumTemperatureLabel, size: 15, textColor: .darkGray)
    self.setLabel(self.maxTemperatureLabel, size: 15, textColor: .darkGray)
  }

  private func setLabel(_ label: UILabel, size: CGFloat, textColor: UIColor) {
    label.font = UIFont.systemFont(ofSize: size)
    label.textColor = textColor
  }


  // MARK: Set Data

  func setData(with cellData: Data) {
    // TODO: cell의 Content
  }
}
