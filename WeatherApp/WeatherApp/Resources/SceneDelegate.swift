//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by 이영우 on 2022/03/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    self.window = UIWindow(windowScene: windowScene)
    self.window?.rootViewController = WeatherListViewController()
    self.window?.makeKeyAndVisible()
  }
}
