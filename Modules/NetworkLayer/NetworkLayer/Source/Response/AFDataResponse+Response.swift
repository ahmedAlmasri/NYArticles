//
//  AFDataResponse+Response.swift
//  NetworkLayer
//
//  Created by Ahmad Almasri on 5/21/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Alamofire

extension AFDataResponse {
	
	func toResponse(_ factory: Factory?, data: Data?) -> Response {
		
	 Response(urlRequest: self.request, data: data,
			  httpURLResponse: self.response,
			  factory: factory)
	}
}
