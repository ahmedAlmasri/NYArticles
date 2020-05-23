//
//  Rx+ResponseMap.swift
//  NetworkLayer
//
//  Created by Ahmad Almasri on 5/23/20.
//

import Foundation
import RxSwift

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
	public func map<T>(to type: T.Type) -> Single<T> {
		
		return flatMap { response -> Single<T> in
			return .just(try response.body(types: type))
		}
	}
}

extension ObservableType where Element == Response {
	public func map<T>(to type: T.Type) -> Observable<T> {
		return flatMap { response -> Observable<T> in
			return .just(try response.body(types: type))
		}
	}
}
