//
//  MockAPIClient.swift
//  NetworkLayer-Unit-UnitTests
//
//  Created by Ahmad Almasri on 5/22/20.
//

import Foundation
import Alamofire
@testable import NetworkLayer

class MockAPIClient {
	
	static var mockProvider: RequestProvider {
		
		let configuration = URLSessionConfiguration.af.default
		   configuration.protocolClasses = [MockURLProtocol.self] + (configuration.protocolClasses ?? [])
		   let session = Session(configuration: configuration)
		
		return RequestProvider(baseUrl: "https://example.com", session: session)
	}
}
