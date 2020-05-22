//
//  CodableConverterFactory.swift
//  NetworkLayer
//
//  Created by Ahmad Almasri on 5/21/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation

final public class CodableConverterFactory: Factory {
	  
	let jsonDecoder: JSONDecoder
	
	public init(jsonDecoder: JSONDecoder = JSONDecoder()) {
		self.jsonDecoder = jsonDecoder
	}
	
	override func responseBodyConverter<T>(type: T.Type) -> Converter<Data, T>? {
	
		return CodableConverter(self.jsonDecoder, type: type)

	}
}
