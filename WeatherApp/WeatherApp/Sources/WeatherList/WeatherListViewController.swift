//
//  WeatherListViewController.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/18.
//

import UIKit

import RxDataSources
import RxSwift
import SnapKit

final class WeatherListViewController: UIViewController {

  // MARK: Properties

  private let weatherListViewModel = WeatherListViewModel()
  private let weatherListView = UITableView()
  private let disposeBag = DisposeBag()

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

    self.bind()
  }


  // MARK: Bind

  private func bind() {
    let dataSource = RxTableViewSectionedReloadDataSource<WeatherListSection> { dataSource, tableView, indexPath, item in
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "WeatherListViewCell",
        for: indexPath
      ) as? WeatherListViewCell else {
        return UITableViewCell()
      }
      let cellViewModel = WeatherListCellViewModel(cellData: item)
      cell.bind(with: cellViewModel)
      return cell
    }

    dataSource.titleForHeaderInSection = { dataSource, index in
      return dataSource.sectionModels[index].header
    }

    let output = self.weatherListViewModel.transform(input: WeatherListViewModel.Input())

    output.weatherListSection
      .skip(2)
      .bind(to: self.weatherListView.rx.items(dataSource: dataSource))
      .disposed(by: self.disposeBag)
  }
}
