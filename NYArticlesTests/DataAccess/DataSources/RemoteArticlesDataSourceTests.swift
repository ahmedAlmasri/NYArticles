//
//  RemoteArticlesDataSource.swift
//  NYArticlesTests
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import XCTest
import RxBlocking

@testable import NYArticles

class RemoteArticlesDataSourceTests: XCTestCase {
	
	var dataSource: RemoteArticlesDataSource!
	
	override func setUp() {
		super.setUp()
		dataSource = RemoteArticlesDataSource(provider: MockRequestProvider(baseUrl: "https://example.com/"))
	}
	
	override func tearDown() {
		super.tearDown()
		
		dataSource = nil
	}
	
	func test_getAll_request() {
		
		let response = try? dataSource.getAll().toBlocking().first()
		XCTAssertEqual(response?.urlRequest?.url?.path, "/"+ArticlesEndPoint.articles.path.path)
		XCTAssertEqual(response?.urlRequest?.httpMethod, ArticlesEndPoint.articles.path.httpMethod.rawValue)
		
	}
	
}
