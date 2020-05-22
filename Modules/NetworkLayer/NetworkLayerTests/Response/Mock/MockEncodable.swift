//
//  MockEncodable.swift
//  NetworkLayer-Unit-UnitTests
//
//  Created by Ahmad Almasri on 5/22/20.
//

import Foundation

struct FooEncodable: Codable, Equatable {
	let params = ["foo": "bar"]
	
}

struct BarEncodable: Codable, Equatable {
	let foo: Bool
	let bar: String? = "bar"
}

struct NotEncodable {
	let foo: Bool
}

extension Encodable {
	var data: Data {
		do {
			return try JSONEncoder().encode(self)
		} catch {
			
			fatalError("\(error)")
		}
		
	}
}
