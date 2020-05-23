//
//  HomeCoordinator.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import UIKit

class DetailsCoordinator: Coordinator {
	
	public var childCoordinators: [Coordinator] = []
	
	public var navigationController: UINavigationController
	weak var delegate: DetailsControllerDelegate?
	private let article: Article
	
	 init(navigationController: UINavigationController, article: Article) {
		self.navigationController = navigationController
		self.article = article
	}
	
	public func start() {
		let viewModel = DetailsViewModel(article: self.article)
		let detailsController = DetailsController(viewModel: viewModel)
		detailsController.delegate = delegate
		self.navigationController.pushViewController(detailsController, animated: true)
	}
}
