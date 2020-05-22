//
//  RxRequestProviderTests.swift
//  NetworkLayerTests
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import XCTest
import Nimble
import RxBlocking
@testable import NetworkLayer

class RxRequestProviderTests: XCTestCase {
	var provider: RequestProvider!
	
	override func setUp() {
		super.setUp()
		provider = MockAPIClient.mockProvider
	}
	
	override func tearDown() {
		super.tearDown()
		provider = nil
	}
	
	func test_request_success() {
        MockURLProtocol.responseWithStatusCode(code: 200)
		let blockResponse = provider.rx.request(endPoint: MockEndPoint.login).toBlocking()
		XCTAssertEqual(try blockResponse.first()?.httpURLResponse?.statusCode, 200)
	}
	
	func test_request_failure_status_code() {
        MockURLProtocol.responseWithStatusCode(code: 400)
        
		let blockResponse = provider.rx.request(endPoint: MockEndPoint.login).toBlocking()
		do {
			 let response = try blockResponse.first()
			XCTFail("status code 400 must be call as a failure for this response: \(response!)")

		} catch {
			XCTAssertTrue(error.asAFError!.isResponseValidationError)

		}
	}
	
}
