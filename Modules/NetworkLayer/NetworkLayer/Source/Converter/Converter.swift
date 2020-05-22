//
//  Converter.swift
//  NetworkLayer
//
//  Created by Ahmad Almasri on 5/21/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation

class Converter<T, U> {

	func convert(value: T) throws -> U {
		
		fatalError("Converter not implemented")
	}
}

public class Factory {
	
	var className: String {
		
		return "\(self)"
	}
	
	func responseBodyConverter<T>(type: T.Type) -> Converter<Data, T>? {
		preconditionFailure("Factory not implemented")

	}
}
