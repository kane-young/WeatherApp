//
//  WeatherListViewController.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/18.
//

import UIKit

import SnapKit

final class WeatherListViewController: UIViewController {

  // MARK: Properties

  private let weatherListView = UITableView()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.layout()
    self.attribute()
    self.configure()
  }

  private func layout() {
    self.view.addSubview(self.weatherListView)

    self.weatherListView.snp.makeConstraints {
      $0.edges.equalTo(self.view.safeAreaLayoutGuide)
    }
  }

  private func attribute() {
    self.view.backgroundColor = .systemBackground
  }

  private func configure() {
    self.weatherListView.register(
      WeatherListViewCell.self,
      forCellReuseIdentifier: "WeatherListViewCell"
    )
  }
}
