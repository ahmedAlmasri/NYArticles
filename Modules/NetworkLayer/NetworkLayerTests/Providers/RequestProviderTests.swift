//
//  RequestProviderTests.swift
//  NetworkLayer-Unit-UnitTests
//
//  Created by Ahmad Almasri on 5/22/20.
//

import XCTest
import Alamofire
@testable import NetworkLayer

class RequestProviderTests: XCTestCase {
	
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
        let expectation = XCTestExpectation(description: "Performs a request")

		provider.request(endPoint: MockEndPoint.login) { (result) in
			
			switch result {
				
			case .success(let response):
				XCTAssertEqual(response.httpURLResponse?.statusCode, 200)
				expectation.fulfill()
			case .failure(let error):
				print(error)
				XCTFail(error.localizedDescription)
				expectation.fulfill()
			}
		}
        wait(for: [expectation], timeout: 3)
	}
	
	func test_request_failure_status_code() {
        MockURLProtocol.responseWithStatusCode(code: 400)
        let expectation = XCTestExpectation(description: "Performs a request")

		provider.request(endPoint: MockEndPoint.login) { (result) in
			
			switch result {
				
			case .success(let response):
				XCTFail("status code 400 must be call as a failure for this response: \(response)")
			case .failure(let error):
			   XCTAssertTrue(error.asAFError!.isResponseValidationError)
				expectation.fulfill()
			}
		}
        wait(for: [expectation], timeout: 3)
	}
	
	func test_request_failure_url() {
		provider.baseUrl = "😊/"
		// MockURLProtocol.responseWithStatusCode(code: 200)
        let expectation = XCTestExpectation(description: "Performs a request")

		provider.request(endPoint: MockEndPoint.login) { (result) in
			
			switch result {
				
			case .success(let response):
				XCTFail("invalid base Url must be return a failure error for this response: \(response)")
			case .failure(let error):
				print(error)
				XCTAssertEqual(error as? EndPintError, EndPintError.invalidUrl)
				expectation.fulfill()
			}
		}
        wait(for: [expectation], timeout: 3)
	}
	
	func test_request_add_factory() {
		let providerFactory = provider.addConverterFactory(CodableConverterFactory())
		XCTAssertNotNil(providerFactory.factory)
	    XCTAssert(providerFactory.factory is CodableConverterFactory)
 	}
	
	func test_request_add_Interceptor() {
		let providerInterceptor = provider.interceptor(MockInterceptor())
		XCTAssertNotNil(providerInterceptor.session.interceptor)
	    XCTAssert(providerInterceptor.session.interceptor is MockInterceptor)

 	}
}
