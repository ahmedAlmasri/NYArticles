//
//  APIClient.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation
import NetworkLayer
import Swinject
import SwinjectAutoregistration

public class ProviderAssembly: Assembly {
	public init() {}
	public func assemble(container: Container) {
		container.autoregister(RequestProvider.self) { _ -> RequestProvider in
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			return RequestProvider(baseUrl: "http://api.nytimes.com/svc/mostpopular/v2/")
				.addConverterFactory(CodableConverterFactory(jsonDecoder: decoder))
		}
		
	}
}
