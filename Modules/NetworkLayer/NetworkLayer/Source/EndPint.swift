//
//  EndPint.swift
//  NetworkLayer
//
//  Created by Ahmad Almasri on 5/21/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation
import Alamofire

public enum Path {
	
	case connect(path: String)
	case delete(path: String)
	case get(path: String)
	case head(path: String)
	case options(path: String)
	case post(path: String)
	case put(path: String)
	case trace(path: String)
	
	public var path: String {
		
		switch self {
		case let .connect(path),
			 let .delete(path),
			 let .get(path),
			 let .head(path),
			 let .options(path),
			 let .post(path),
			 let .put(path),
			 let .trace(path):
			return path
		}
	}
	
	public var httpMethod: HTTPMethod {
		
		switch self {
		case .connect:
			return .connect
		case .delete:
			return .delete
		case .get:
			return .get
		case .head:
			return .head
		case .options:
			return .options
		case .post:
			return .post
		case .put:
			return .put
		case .trace:
			return .trace
	
		}
	}
	var encoding: ParameterEncoding {
		
		switch self {
		case .get:
			return URLEncoding.default
		default:
			return JSONEncoding.default
	
		}
	}
}

public protocol EndPoint {
	var path: Path { get }
	var header: [String: String]? { get }
	var encoding: ParameterEncoding { get }
	
}

public extension EndPoint {
	
	var encoding: ParameterEncoding {
	
		return path.encoding
	}
	
	var header: [String: String]? { return  nil }
	
	 internal var httpMethod: HTTPMethod {
		return path.httpMethod
	}

	internal func fullUrl(_ baseUrl: String) throws -> URL {
		
		let pathUrl = String(format: "%@%@", baseUrl, path.path)
		
		guard let url = URL(string: pathUrl)  else {
				throw EndPintError.invalidUrl
		}
		
		return url
	}
}
