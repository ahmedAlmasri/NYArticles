//
//  UIViewController+Resolve.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation
import Swinject

public extension UIViewController {
	
	static func resolve() -> Self {
		
		return Assembler.shared.resolver.resolve(Self.self)!
	}
}
