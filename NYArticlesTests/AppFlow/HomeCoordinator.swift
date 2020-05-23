//
//  Home.swift
//  NYArticlesTests
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import XCTest
@testable import NYArticles

class HomeCoordinatorTests: XCTestCase {
	var coordinator: HomeCoordinator!
	
	override func setUp() {
		super.setUp()
		coordinator = HomeCoordinator(navigationController: UINavigationController())
	}
	
	override func tearDown() {
		coordinator = nil
		super.tearDown()
	}
	
	func test_start() {
		coordinator.start()
		XCTAssertTrue(coordinator.navigationController.visibleViewController is HomeController)
	}
	
	func test_show_signIn() {
		let article = Article(publishedDate: "testDate", source: "",
							  type: "", title: "", abstract: "", byline: "",
							  section: "", url: "")
		coordinator.showDetails(with: article)
		XCTAssertFalse(coordinator.childCoordinators.isEmpty)
		let detailsController = coordinator.navigationController.visibleViewController as? DetailsController
		XCTAssertNotNil(detailsController)
		XCTAssertEqual(detailsController?.viewModel.article.publishedDate, "testDate")
		
		coordinator.removeDetails()
		
		XCTAssertTrue(coordinator.childCoordinators.isEmpty)

	}
}
