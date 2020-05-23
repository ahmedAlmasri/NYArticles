//
//  AppCoordinatorTests.swift
//  NYArticlesTests
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import XCTest
@testable import NYArticles

class AppCoordinatorTests: XCTestCase {
	var coordinator: AppCoordinator!
	
	override func setUp() {
		super.setUp()

		coordinator = AppCoordinator(window: UIWindow())
	}
	
	override func tearDown() {
		coordinator = nil
		super.tearDown()
	}
	
	func test_start() {
		coordinator.start()
		XCTAssertNotNil(coordinator.window?.rootViewController)
	}

}
