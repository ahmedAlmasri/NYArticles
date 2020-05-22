//
//  ResponseTests.swift
//  NetworkLayer-Unit-UnitTests
//
//  Created by Ahmad Almasri on 5/22/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import XCTest
import Nimble
@testable import NetworkLayer

class ResponseTests: XCTestCase {
	let url = URL(string: "http://example.com")!
	var request: URLRequest!
	
	override func setUp() {
		super.setUp()
		 request = URLRequest(url: url)
	}
	override func tearDown() {
		super.tearDown()
		request = nil
	}
	
	func test_description_withValues() {
		let data = Data(base64Encoded: "data")
		let httpURLResponse = HTTPURLResponse(url: url,
											  statusCode: 200, httpVersion: nil, headerFields: nil)
		let response = Response(urlRequest: request, data: data,
								httpURLResponse: httpURLResponse, factory: CodableConverterFactory())
		
		XCTAssertEqual(response.description,
					   """
							Requested URL: http://example.com,
							Status Code: 200,
							Data Count: 3,
							factory: NetworkLayer.CodableConverterFactory
							""")
		
		XCTAssertEqual(response.debugDescription,
					   """
			 Requested URL: http://example.com,
			 Status Code: 200,
			 Data Count: 3,
			 factory: NetworkLayer.CodableConverterFactory
			 """)
	}
	
	func test_description_withEmpty() {
		let response = Response(urlRequest: nil, data: nil, httpURLResponse: nil, factory: nil)
		
		XCTAssertEqual(response.description,
					   "Requested URL: ,\nStatus Code: -1,\nData Count: -1,\nfactory: ")
		XCTAssertEqual(response.debugDescription,
					   "Requested URL: ,\nStatus Code: -1,\nData Count: -1,\nfactory: ")
	}
	
	func test_jsonString_success() {
		let data = FooEncodable().data
		let httpURLResponse = HTTPURLResponse(url: url,
											  statusCode: 200, httpVersion: nil, headerFields: nil)
		let response = Response(urlRequest: request, data: data, httpURLResponse: httpURLResponse, factory: nil)
		
		XCTAssertEqual(response.jsonString, "{\n  \"params\" : {\n    \"foo\" : \"bar\"\n  }\n}")
	}
	
	func test_json_success() {
		let data = FooEncodable().data
		let httpURLResponse = HTTPURLResponse(url: url,
											  statusCode: 200, httpVersion: nil, headerFields: nil)
		let response = Response(urlRequest: request, data: data, httpURLResponse: httpURLResponse, factory: nil)
		
		let json = response.json
		
		let decodedData = try? JSONSerialization.data(withJSONObject: json!, options: .fragmentsAllowed)
		
		XCTAssertEqual(decodedData, data)
	}
	
	func test_mapTo_success() {
		let fooInstance = FooEncodable()
		let data = fooInstance.data
		let httpURLResponse = HTTPURLResponse(url: url,
											  statusCode: 200, httpVersion: nil, headerFields: nil)
		let response = Response(urlRequest: request, data: data,
								httpURLResponse: httpURLResponse, factory: CodableConverterFactory())
		
		XCTAssertEqual(try? response.body(types: FooEncodable.self), fooInstance)
	}
	
	func test_jsonString_noData() {
		let  data = "😊".data(using: .utf8)!
		let httpURLResponse = HTTPURLResponse(url: url,
											  statusCode: 200, httpVersion: nil, headerFields: nil)
		let response = Response(urlRequest: request, data: data, httpURLResponse: httpURLResponse, factory: nil)
		
		XCTAssertNil(response.jsonString)
	}
	func test_mapTo_error_noData() {
		let httpURLResponse = HTTPURLResponse(url: url,
											  statusCode: 200, httpVersion: nil, headerFields: nil)
		let response = Response(urlRequest: request, data: nil, httpURLResponse: httpURLResponse, factory: nil)
		
		XCTAssertThrowsError(try response.body(types: FooEncodable.self), "Should throw error") { error in
			XCTAssertEqual(error as? ParsingError, ParsingError.dataIsEmpty)
		}
	}
	
	func test_mapTo_error_noFactory() {
		let data = FooEncodable().data
		let httpURLResponse = HTTPURLResponse(url: url,
											  statusCode: 200, httpVersion: nil, headerFields: nil)
		let response = Response(urlRequest: request, data: data, httpURLResponse: httpURLResponse, factory: nil)
		
		XCTAssertThrowsError(try response.body(types: FooEncodable.self), "Should throw error") { error in
			XCTAssertEqual(error as? ParsingError, ParsingError.factoryNotImplemented)
		}
	}
	
	func test_mapTo_error_parserType() {
		let  data = FooEncodable().data
		let httpURLResponse = HTTPURLResponse(url: url,
											  statusCode: 200, httpVersion: nil, headerFields: nil)
		let response = Response(urlRequest: request, data: data,
								httpURLResponse: httpURLResponse, factory: Factory())
		
		expect {_ = try response.body(types: FooEncodable.self)}.to(throwAssertion())
	}
	
	func test_mapTo_error_decoding() {
		let data = FooEncodable().data
		let httpURLResponse = HTTPURLResponse(url: url,
											  statusCode: 200, httpVersion: nil, headerFields: nil)
		let response = Response(urlRequest: request, data: data,
								httpURLResponse: httpURLResponse, factory: CodableConverterFactory())
		
		XCTAssertThrowsError(try response.body(types: BarEncodable.self), "Should throw error") { error in
				XCTAssertEqual(error.localizedDescription,
							   "The data couldn’t be read because it is missing.")
		}
	}
}
