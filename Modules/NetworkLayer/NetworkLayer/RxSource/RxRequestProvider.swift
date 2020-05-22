//
//  RxRequestProvider.swift
//  NetworkLayer
//
//  Created by Ahmad Almasri on 5/21/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import RxSwift

extension RequestProvider: ReactiveCompatible {}

public extension Reactive where Base: RequestProvider {
	
	func request(endPoint: EndPoint, parameters: [String: Any]? = nil)-> Single<Response> {
		
		return Single.create { single in
			
			self.base.request(endPoint: endPoint, parameters: parameters) { (result) in
				switch result {
					
				case .success(let response):
					single(.success(response))
				case .failure(let error):
					single(.error(error))
				}
			}
			return Disposables.create()
		}
	}
}
