//
//  HomeAssembly.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration

public class AuthAssembly: Assembly {
	
	public func assemble(container: Container) {
		
		container.autoregister(HomeViewModel.self, initializer: HomeViewModel.init)
		container.autoregister(HomeController.self, initializer: HomeController.init)
	}
}
