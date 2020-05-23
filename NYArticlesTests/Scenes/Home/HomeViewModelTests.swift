//
//  HomeViewModelTests.swift
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

class HomeViewModelTests: XCTestCase {
	var repo: MockArticlesRepository!
	var viewModel: HomeViewModel!
	
	let disposeBag = DisposeBag()
	
	override func setUp() {
		super.setUp()
		
		repo = MockArticlesRepository()
		viewModel = HomeViewModel(repository: repo)
	}
	
	func test_transform_trigger_getAll() {
		
		let trigger = PublishSubject<Void>()
		let input = createInput(trigger: trigger)
		let output = viewModel.transform(input: input)
		
		output.articles.drive().disposed(by: disposeBag)
		trigger.onNext(())
		
		XCTAssert(repo.isGetAllCalled)
		
	}
	
	func test_transform_getAll_trackFetching() {
		
		let trigger = PublishSubject<Void>()
		let output = viewModel.transform(input: createInput(trigger: trigger))
		let expectedFetching = [true, false]
		var actualFetching: [Bool] = []
		
		output.fetching
			.do(onNext: { actualFetching.append($0) },
				onSubscribe: { actualFetching.append(true) })
			.drive()
			.disposed(by: disposeBag)
		trigger.onNext(())
		
		XCTAssertEqual(actualFetching, expectedFetching)
	}
	
	func test_transform_getAll_trackError() {
		let trigger = PublishSubject<Void>()
		repo.getAllResult = Single<ArticlesWrapper>.error(TestError.test)
		let output = viewModel.transform(input: createInput(trigger: trigger))
		
		output.error.drive().disposed(by: disposeBag)
		output.articles.drive().disposed(by: disposeBag)
		trigger.onNext(())
		
		let error = try? output.error.toBlocking().first()
		
		XCTAssertNotNil(error)
	}
	func test_transform_selected_article() {
	   let select = PublishSubject<IndexPath>()
		let articles = createArticles()
		repo.getAllResult = Single<ArticlesWrapper>.just(ArticlesWrapper(results: articles))
	   let output = viewModel.transform(input: createInput(selection: select))
	   // act
	    output.selected.drive().disposed(by: disposeBag)
		output.articles.drive().disposed(by: disposeBag)
	   select.onNext(IndexPath(row: 1, section: 0))
		let article = try? output.selected.toBlocking().first()

		XCTAssertEqual("\(article!)", "\(articles[1])")
	 }
	
	private func createInput(trigger: Observable<Void> = Observable.just(()),
							 selection: Observable<IndexPath> = Observable.never())
		-> HomeViewModel.Input {
			
			HomeViewModel.Input(fetchTrigger: trigger.asDriver(onErrorJustReturn: ()),
								selection: selection.asDriver(onErrorJustReturn: IndexPath(item: 0, section: 0)))
	}
	
	private func createArticles() -> [Article] {
	  return [
		Article(publishedDate: "date 1", source: "source 1",
				type: "type 1", title: "title 1", abstract: "abstract 1",
				byline: "byline 1", section: "section 1", url: "url 1"),
		Article(publishedDate: "date 2", source: "source 2",
				type: "type 2", title: "title 2", abstract: "abstract 2",
				byline: "byline 2", section: "section 2", url: "url 2")

	  ]
	}
	
	enum TestError: Error {
		case test
	}
}
