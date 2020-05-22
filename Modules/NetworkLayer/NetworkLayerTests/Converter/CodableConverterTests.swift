//
//  CodableConverterTests.swift
//  Alamofire
//
//  Created by Ahmad Almasri on 5/23/20.
//

import XCTest
@testable import NetworkLayer

class CodableConverterTests: XCTestCase {
	
	let factory: Factory = CodableConverterFactory()

	func test_json_valid_Type() {
	     
		let converter = factory.responseBodyConverter(type: BarEncodable.self)

		XCTAssertEqual(try? converter?.convert(value: BarEncodable(foo: true).data).foo, true)
	}
	
	func test_invalid_format_type() {
		let converter = factory.responseBodyConverter(type: String.self)

		XCTAssertThrowsError(try converter?.convert(value: FooEncodable().data)) { (error) in
			XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
		}
	}
	
	func test_not_valid_decodable_type() {
		let converter = factory.responseBodyConverter(type: NotEncodable.self)

		XCTAssertThrowsError(try converter?.convert(value: FooEncodable().data)) { (error) in
			print(error)
			XCTAssertEqual(error as? ParsingError, ParsingError.typeMustBeDecodable)
		}
	}
}
