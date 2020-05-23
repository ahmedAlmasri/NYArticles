//
//  MockArticlesRepository.swift
//  NYArticlesTests
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation
import RxSwift
@testable import NYArticles

class MockArticlesRepository: ArticlesRepositoryProtocol {
	  var isGetAllCalled = false
	var getAllResult: Single<ArticlesWrapper> = Observable.empty().asSingle()

	func getAll() -> Single<ArticlesWrapper> {
		isGetAllCalled = true
		return getAllResult
	}
	
}
