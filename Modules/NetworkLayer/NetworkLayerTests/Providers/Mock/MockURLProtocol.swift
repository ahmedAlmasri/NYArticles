//
//  MockURLProtocol.swift
//  NetworkLayer-Unit-UnitTests
//
//  Created by Ahmad Almasri on 5/22/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation

final class MockURLProtocol: URLProtocol {
    
    enum ResponseType {
        case error(Error)
        case success(HTTPURLResponse, Data)
    }
    static var responseType: ResponseType!
    
    private lazy var session: URLSession = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    private(set) var activeTask: URLSessionTask?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return false
    }
    
    override func startLoading() {
        activeTask = session.dataTask(with: request.urlRequest!)
        activeTask?.cancel()
    }
    
    override func stopLoading() {
        activeTask?.cancel()
    }
}

// MARK: - URLSessionDataDelegate
extension MockURLProtocol: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        client?.urlProtocol(self, didLoad: data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        switch MockURLProtocol.responseType {
        case .error(let error)?:
            client?.urlProtocol(self, didFailWithError: error)
        case .success(let response, let data)?:
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
			client?.urlProtocol(self, didLoad: data)
        default:
            break
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
}

extension MockURLProtocol {
    
    enum MockError: Error {
        case none
    }
    
    static func responseWithFailure() {
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.error(MockError.none)
    }
    
	static func responseWithStatusCode(code: Int, data: Data = "{}".data(using: .utf8)!) {
		 let cannedHeaders = ["Content-Type" : "application/json; charset=utf-8"]
		let response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: code, httpVersion: "HTTP/1.1", headerFields: cannedHeaders)!
		MockURLProtocol.responseType = MockURLProtocol.ResponseType.success(response, data)
    }
}
