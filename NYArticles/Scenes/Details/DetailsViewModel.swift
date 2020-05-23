//
//  DetailsViewModel.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import RxCocoa
import RxSwift

class DetailsViewModel {
		
	struct Output {
		var article: Driver<Article>
	}
	
	let article: Article
	init(article: Article) {
		
		self.article = article
	}
	
	func transform() -> Output {

		let dataDriver = Observable<Article>.just(self.article).asDriver(onErrorJustReturn: self.article)
		return Output(article: dataDriver)
	}
}
