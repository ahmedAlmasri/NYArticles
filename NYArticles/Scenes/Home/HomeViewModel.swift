//
//  HomeViewModel.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
	
	private let repository: ArticlesRepositoryProtocol
	init(repository: ArticlesRepositoryProtocol) {
		self.repository = repository
	}
	
	struct Input {
		let fetchTrigger: Driver<Void>
		//let selection: PublishSubject<Void>
	}
	struct Output {
		var articles: Driver<[Article]>
		var error: Driver<Error>
		let fetching: Driver<Bool>
	}
	
	func transform(input: Input) -> Output {
		
		let errorTracker = ErrorTracker()
		let activityIndicator = ActivityIndicator()
		
		let dataDrive = repository.getAll()
			.trackActivity(activityIndicator)
			.trackError(errorTracker)
			.map { $0.results }
			.asDriver(onErrorJustReturn: [])
		
		let error = errorTracker.asDriver()
		let fetching = activityIndicator.asDriver()
		
		return Output(articles: dataDrive, error: error, fetching: fetching)
	}
	
}
