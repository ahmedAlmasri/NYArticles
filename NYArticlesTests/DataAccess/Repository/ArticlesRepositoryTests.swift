//
//  ArticlesRepository.swift
//  NYArticlesTests
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import XCTest
import RxSwift
import NetworkLayer
import RxBlocking

@testable import NYArticles

class ArticlesRepositoryTests: XCTestCase {
	
	var repo: ArticlesRepository!
	var dataSource: MockRemoteArticlesDataSource!
	override func setUp() {
		super.setUp()
		dataSource = MockRemoteArticlesDataSource()
		repo = ArticlesRepository(remoteDataSource: dataSource)
	}
	
	override func tearDown() {
		super.tearDown()
		dataSource = nil
		repo = nil
	}
	
	func test_getAll_request() {
		
		_ = try? repo.getAll().toBlocking().first()
		
		XCTAssertTrue(dataSource.isGetAllCalled)
	}
	
}

class MockRemoteArticlesDataSource: RemoteArticlesDataSourceProtocol {
	var isGetAllCalled = false
	func getAll() -> Single<Response> {
		isGetAllCalled = true
		let response = Response(urlRequest: nil,
		data: nil, httpURLResponse: nil, factory: nil)
		return Single.just(response)
	}
}
