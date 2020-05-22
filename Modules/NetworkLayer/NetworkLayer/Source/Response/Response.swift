//
//  Response.swift
//  NetworkLayer
//
//  Created by Ahmad Almasri on 5/21/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation

public final class Response: CustomDebugStringConvertible {
	
	public let urlRequest: URLRequest?
	public let data: Data?
	public let httpURLResponse: HTTPURLResponse?
	
	public var factory: Factory?
	
	public var description: String {
		return """
		Requested URL: \(urlRequest?.url?.absoluteString ?? ""),
		Status Code: \(httpURLResponse?.statusCode ?? -1),
		Data Count: \(data?.count ?? -1),
		factory: \(factory?.className ?? "")
		"""
	}
	
	public var debugDescription: String {
		return description
	}
	
	public var jsonString: NSString? {
		   return data?.jsonString
	   }

	   public var json: Any? {
		   return data?.json
	   }
	
	public init( urlRequest: URLRequest?, data: Data?,
				 httpURLResponse: HTTPURLResponse?, factory: Factory?) {
		self.urlRequest = urlRequest
		self.data = data
		self.httpURLResponse = httpURLResponse
		self.factory = factory
	}
	
	public func body<T>(types: T.Type) throws -> T {
		guard let data = self.data, let factory = self.factory else {
			
			throw self.data == nil ? ParsingError.dataIsEmpty : ParsingError.factoryNotImplemented
		}
	
		let convert = factory.responseBodyConverter(type: T.self)
		do {
			guard let result = try convert?.convert(value: data) else {
				
				throw ParsingError.parserTypeNotCorrect
			}

		return result
		} catch {
			throw error
		}
		
	}
}
