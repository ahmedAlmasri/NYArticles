//
//  EndPointTest.swift
//  NetworkLayer-Unit-UnitTests
//
//  Created by Ahmad Almasri on 5/21/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import XCTest
import Alamofire
@testable import NetworkLayer

class EndPointPathTests: XCTestCase {
	
	func test_path_method_success() {
		XCTAssertEqual(Path.put(path: "foo").httpMethod.rawValue, "PUT")
		XCTAssertEqual(Path.get(path: "foo").httpMethod.rawValue, "GET")
		XCTAssertEqual(Path.post(path: "foo").httpMethod.rawValue, "POST")
		XCTAssertEqual(Path.delete(path: "foo").httpMethod.rawValue, "DELETE")
		XCTAssertEqual(Path.connect(path: "foo").httpMethod.rawValue, "CONNECT")
		XCTAssertEqual(Path.head(path: "foo").httpMethod.rawValue, "HEAD")
		XCTAssertEqual(Path.options(path: "foo").httpMethod.rawValue, "OPTIONS")
		XCTAssertEqual(Path.trace(path: "foo").httpMethod.rawValue, "TRACE")
	}
	
	func test_path_success() {
		XCTAssertEqual(Path.put(path: "put_foo").path, "put_foo")
		XCTAssertEqual(Path.get(path: "get_foo").path, "get_foo")
		XCTAssertEqual(Path.post(path: "post_foo").path, "post_foo")
		XCTAssertEqual(Path.delete(path: "delete_foo").path, "delete_foo")
		XCTAssertEqual(Path.connect(path: "connect_foo").path, "connect_foo")
		XCTAssertEqual(Path.head(path: "head_foo").path, "head_foo")
		XCTAssertEqual(Path.options(path: "options_foo").path, "options_foo")
		XCTAssertEqual(Path.trace(path: "trace_foo").path, "trace_foo")
	}
	
	func test_encoding_success() {
		
		XCTAssert(Path.put(path: "put_foo").encoding is JSONEncoding)
		XCTAssert(Path.get(path: "get_foo").encoding  is URLEncoding)
		XCTAssert(Path.post(path: "post_foo").encoding  is JSONEncoding)
		XCTAssert(Path.delete(path: "delete_foo").encoding  is JSONEncoding)
		XCTAssert(Path.connect(path: "connect_foo").encoding  is JSONEncoding)
		XCTAssert(Path.head(path: "head_foo").encoding  is JSONEncoding)
		XCTAssert(Path.options(path: "options_foo").encoding  is JSONEncoding)
		XCTAssert(Path.trace(path: "trace_foo").encoding  is JSONEncoding)
	}
}
