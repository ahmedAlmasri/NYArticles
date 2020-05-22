//
//  CodableConverter.swift
//  NetworkLayer
//
//  Created by Ahmad Almasri on 5/21/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation

final class CodableConverter<T>: Converter<Data, T> {
	
	var jsonDecoder: JSONDecoder
	let type: T.Type
	init(_ jsonDecoder: JSONDecoder, type: T.Type) {
		self.jsonDecoder = jsonDecoder
		self.type = type
	}
	
	override func convert(value: Data) throws -> T {
		
		do {
			guard let  decodableType = type as? Decodable.Type else {
				throw ParsingError.typeMustBeDecodable
			}
			
			let decoded = try decodableType.init(jsonData: value, jsonDecoder: jsonDecoder)
			
			guard let result = decoded as? T else {
				
				throw ParsingError.filedDecodable
		     }
			
			return result
			
		} catch {
			throw error
		}
	}
}

extension Decodable {
	init(jsonData: Data, jsonDecoder: JSONDecoder) throws {
		self = try jsonDecoder.decode(Self.self, from: jsonData)
	}
}
