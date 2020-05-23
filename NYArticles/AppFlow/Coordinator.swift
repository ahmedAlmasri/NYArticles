//
//  Coordinator.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import UIKit

public protocol Coordinator: class {
	
	var childCoordinators: [Coordinator] { get set }
	var navigationController: UINavigationController { get set}
	func start()
	
}
