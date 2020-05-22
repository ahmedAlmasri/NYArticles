//
//  ConverterTests.swift
//  NetworkLayerTests
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import XCTest
import Nimble
@testable import NetworkLayer

class ConverterTests: XCTestCase {
	
	func test_converter_not_implemented() {
		
		let converter = MockConverter<String>()
		
		expect {_ = try? converter.convert(value: Data())}.to(throwAssertion())

	}
	
	func test_factory_not_implemented() {
		
		let factory = Factory()
		
		expect {_ = factory.responseBodyConverter(type: String.self)}.to(throwAssertion())

	}
	func test_factory_className() {
		
		let factory = Factory()
		
		XCTAssertEqual(factory.className, "NetworkLayer.Factory")

	}
}
