//
//  ArticlesEndPoint.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation
import NetworkLayer

enum ArticlesEndPoint {
	case articles
}

extension ArticlesEndPoint: EndPoint {
	var path: Path {
		switch  self {
		case .articles:
			return .get(path: "viewed/1.json")
		}
	}
	
}
