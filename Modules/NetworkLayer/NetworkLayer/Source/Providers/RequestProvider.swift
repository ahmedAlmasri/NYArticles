//
//  RequestProvider.swift
//  NetworkLayer
//
//  Created by Ahmad Almasri on 5/21/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation
import Alamofire

open class RequestProvider: ProviderProtocol {
	public var session: Session
	var factory: Factory?
	public var baseUrl: String
	internal var successRange = 200...299
	public required init(baseUrl: String, session: Session = Session.default) {
		
		self.baseUrl = baseUrl
		self.session = session
	}
	
	public func interceptor(_ interceptor: Interceptor) -> Self {
		
		self.session = Session(interceptor: interceptor)
		
		return self
	}
	
	public func addConverterFactory(_ factory: Factory) -> RequestProvider {
		
		self.factory = factory
		
		return self
	}
	
	open func request(endPoint: EndPoint, parameters: [String: Any]? = nil,
						 callback: @escaping ProviderCompletionHandler) {
		do {
			let url = try endPoint.fullUrl(baseUrl)
			print(url)
			let headers = HTTPHeaders(endPoint.header ?? [:])
			session.request(url, method: endPoint.httpMethod, parameters: parameters, encoding: endPoint.encoding,
							headers: headers)
				.validate(statusCode: successRange)
				.responseData(completionHandler: { response in
					
					switch response.result {
						
					case .success(let data):
						callback(.success(response.toResponse(self.factory, data: data)))
						
					case .failure(let error):
						callback(.failure(error))
						
					}
				})
			
		} catch {
			callback(.failure(error))
		}
	}
}
