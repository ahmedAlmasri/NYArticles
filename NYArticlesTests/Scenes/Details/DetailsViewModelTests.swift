//
//  DetailsViewModelTests.swift
//  NYArticlesTests
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking
@testable import NYArticles

class DetailsViewModelTests: XCTestCase {
	var viewModel: DetailsViewModel!
	
	let disposeBag = DisposeBag()
	
	override func setUp() {
		super.setUp()
		
		viewModel = DetailsViewModel(article: mockArticle())
	}
	
	func test_transform_trigger_getAll() {
		
		let output = viewModel.transform()
		output.article.drive().disposed(by: disposeBag)
		
		let article = try? output.article.toBlocking().first()
		XCTAssertNotNil(article)
		XCTAssertEqual("\(article!)", "\(mockArticle())")
	}
	
	func mockArticle() -> Article {
		Article(publishedDate: "date 1", source: "source 1",
				type: "type 1", title: "title 1", abstract: "abstract 1",
				byline: "byline 1", section: "section 1", url: "url 1")
	}
}
