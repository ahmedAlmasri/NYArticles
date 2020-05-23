//
//  ArticlesRepository.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation
import RxSwift

protocol ArticlesRepositoryProtocol {
	func getAll() -> Single<ArticlesWrapper>
}

class ArticlesRepository: ArticlesRepositoryProtocol {
	
	let remoteDataSource: RemoteArticlesDataSourceProtocol
	
	public init(remoteDataSource: RemoteArticlesDataSourceProtocol) {
		self.remoteDataSource = remoteDataSource
	}
	func getAll() -> Single<ArticlesWrapper> {
		
		self.remoteDataSource.getAll().map(to: ArticlesWrapper.self)
	}
}
