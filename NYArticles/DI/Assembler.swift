//
//  Assembler.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import Foundation
import Swinject

public protocol DelegateAssembler {
	func assemblies() -> [Assembly]
}
public extension Assembler {
	
	static let shared: Assembler = {
		let container = Container()
		let assemblies: [Assembly] = (UIApplication.shared.delegate as? DelegateAssembler)?.assemblies() ?? []
		let assembler = Assembler(assemblies, container: container)
		return assembler
	}()
}
