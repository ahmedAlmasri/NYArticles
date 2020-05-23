//
//  MockRequestProvider.swift
//  NYArticlesTests
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation
import NetworkLayer

public extension EndPoint {
	
	 func fullUrl(_ baseUrl: String) -> URL {
		
		let pathUrl = String(format: "%@%@", baseUrl, path.path)
		
		return URL(string: pathUrl)!
	}
}

class MockRequestProvider: RequestProvider {
	
	var requestIsCalled = false
	
	override func request(endPoint: EndPoint,
				 parameters: [String: Any]?,
				 callback: @escaping ProviderCompletionHandler) {
		
		requestIsCalled = true
		
		var request = URLRequest(url: endPoint.fullUrl(baseUrl))
		let theJSONData = try? JSONSerialization.data(
			withJSONObject: parameters ?? [:],
		options: [])
		request.httpBody = theJSONData
		request.httpMethod = endPoint.path.httpMethod.rawValue
		let response = Response(urlRequest: request, data: nil, httpURLResponse: nil, factory: nil)
		callback(.success(response))
	}
}
