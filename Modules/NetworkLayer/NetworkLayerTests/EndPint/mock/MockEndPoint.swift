//
//  MockEndPoint.swift
//  NetworkLayer-Unit-UnitTests
//
//  Created by Ahmad Almasri on 5/22/20.
//

import Foundation
@testable import NetworkLayer

enum MockEndPoint {
	
	case login
}

extension MockEndPoint: EndPoint {
	var path: Path {
		
		switch self {
		case .login:
			return .get(path: "login")
		}
	}
}
