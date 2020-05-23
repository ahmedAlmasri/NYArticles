//
//  MainInterceptor.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Alamofire
import NetworkLayer

class MainInterceptor: NetworkLayer.Interceptor {
	
	func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
		
		var urlRequest = urlRequest
		 let url = urlRequest.url
		var component = URLComponents(url: url!, resolvingAgainstBaseURL: true)
		component?.queryItems = [
			URLQueryItem(name: "api-key", value: Environment.apiKey.value)
		]
		urlRequest.url = component?.url
		completion(.success(urlRequest))

	}
}
