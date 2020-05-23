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
	
	private func createInput(trigger: Observable<Void> = Observable.just(()))
		-> HomeViewModel.Input {
			
			HomeViewModel.Input(fetchTrigger: trigger.asDriver(onErrorJustReturn: ()))
	}
	
	enum TestError: Error {
		case test
	}
}
