//
//  EndPointTests.swift
//  NetworkLayer-Unit-UnitTests
//
//  Created by Ahmad Almasri on 5/21/20.
//

import XCTest
import Alamofire
@testable import NetworkLayer

class EndPointTests: XCTestCase {

	func test_full_url_success() {
		let baseUrl = "http://example.com/"
		let login = MockEndPoint.login
		XCTAssertEqual( try login.fullUrl(baseUrl), URL(string: "http://example.com/login"))
	}
   
	func test_full_url_failure() {
		let baseUrl = "😊/"
		let login = MockEndPoint.login
		XCTAssertThrowsError(try login.fullUrl(baseUrl)) { (error) in
			
			XCTAssertEqual(error as? EndPintError, EndPintError.invalidUrl)
		}
	}

	func test_encoding_success() {
		
		XCTAssert(MockEndPoint.login.encoding is URLEncoding)
		
	}
	
	func test_method_success() {
		
		XCTAssertEqual(MockEndPoint.login.httpMethod.rawValue, "GET")
		
	}
	func test_header_success() {
		
		XCTAssertEqual(MockEndPoint.login.header, nil)
		
	}
}
