//
//  RemoteArticlesDataSource.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import RxSwift
import NetworkLayer

protocol RemoteArticlesDataSourceProtocol {
	func getAll() -> Single<Response>
}

class RemoteArticlesDataSource: RemoteArticlesDataSourceProtocol {
	
	private let provider: RequestProvider
	
	init(provider: RequestProvider) {
		self.provider = provider
	}
	
	func getAll() -> Single<Response> {
	
		return provider.rx.request(endPoint: ArticlesEndPoint.articles)
		
	}
	
}
