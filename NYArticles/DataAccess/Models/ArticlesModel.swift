//
//  ArticlesModel.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation

struct ArticlesWrapper: Decodable {
	let results: [Article]
}

struct Article: Decodable {
	
	let publishedDate: String // 3 2
	let source: String
	let type: String
	let title: String // 1
	let abstract: String
	let byline: String // 2
	let section: String // 3 1
	
}
