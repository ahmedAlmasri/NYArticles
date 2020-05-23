//
//  HomeCoordinator.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import UIKit

final class HomeCoordinator: Coordinator {
	
	public var childCoordinators: [Coordinator] = []
	
	public var navigationController: UINavigationController
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		
	}
	
	public func start() {
		let homeController = HomeController.resolve()
		self.navigationController.pushViewController(homeController, animated: true)
		homeController.delegate = self
		
	}
	
}

extension HomeCoordinator: HomeControllerDelegate, DetailsControllerDelegate {
	
	public func removeDetails() {
		childCoordinators.removeLast()
	}
	
	func showDetails(with article: Article) {
		let detailsCoordinator = DetailsCoordinator(navigationController: self.navigationController, article: article)
		detailsCoordinator.delegate = self
		
		childCoordinators.append(detailsCoordinator)
		detailsCoordinator.start()
	}
}
