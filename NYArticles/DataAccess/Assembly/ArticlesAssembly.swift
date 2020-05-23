//
//  ArticlesAssembly.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import NetworkLayer
public class ArticlesAssembly: Assembly {
	public init() {}
	public func assemble(container: Container) {
		container.autoregister(RemoteArticlesDataSourceProtocol.self, initializer: RemoteArticlesDataSource.init)
		container.autoregister(ArticlesRepositoryProtocol.self, initializer: ArticlesRepository.init)
		
	}
}
