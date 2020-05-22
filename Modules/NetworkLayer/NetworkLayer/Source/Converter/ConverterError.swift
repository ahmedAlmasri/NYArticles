//
//  ConverterError.swift
//  NetworkLayer
//
//  Created by Ahmad Almasri on 5/21/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation

public enum ParsingError: Error {
	case dataIsEmpty
	case factoryNotImplemented
	case parserTypeNotCorrect
	case typeMustBeDecodable
	case filedDecodable
}
