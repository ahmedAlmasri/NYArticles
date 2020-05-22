//
//  ProviderProtocol.swift
//  Alamofire
//
//  Created by Ahmad Almasri on 5/21/20.
//

import Foundation
import Alamofire

public protocol Interceptor: RequestInterceptor {}

public typealias ProviderCompletionHandler = (Result<Response, Error>) -> Void

public protocol ProviderProtocol {
	var session: Session {get set}
	var baseUrl: String { get set}
	func interceptor(_ interceptor: Interceptor) -> Self
	init(baseUrl: String, session: Session)
	
	func request(endPoint: EndPoint, parameters: [String: Any]?,
	callback: @escaping ProviderCompletionHandler)
}
