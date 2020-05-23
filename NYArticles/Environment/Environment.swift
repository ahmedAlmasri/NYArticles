//
//  ENV.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation

enum Environment: String {
	case apiURL = "API_URL"
	case apiKey = "API_KEY"
	
	private enum MainKey: String {
		case configKeys = "CONFIG_KEYS"
	}
	var value: String {
		guard let dict = Bundle.main.infoDictionary,
			let  configKeys = dict[MainKey.configKeys.rawValue] as? [String: String] else {
				fatalError("Plist file not found")
		}
		return configKeys[self.rawValue]!
	}
}
