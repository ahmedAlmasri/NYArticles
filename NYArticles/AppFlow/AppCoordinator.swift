//
//  AppCoordinator.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation
import UIKit

public final class AppCoordinator: Coordinator {
	
	public var childCoordinators: [Coordinator] = []
	
	public var navigationController: UINavigationController
    var window: UIWindow!
	
	public init(window: UIWindow) {
		self.window = window
		self.navigationController = UINavigationController()
	}
	
	public func start() {
		window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
		showHome()
	}
	
	func showHome() {
		let homeCoordinator = HomeCoordinator(navigationController: self.navigationController)
		childCoordinators.append(homeCoordinator)
		homeCoordinator.start()
	}
}
