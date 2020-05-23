//
//  DetailsController.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import UIKit

public protocol DetailsControllerDelegate: class {
	func removeDetails()
}

class DetailsController: UIViewController {
	
	public weak var delegate: DetailsControllerDelegate?
	
	let contentView = DetailsView()
	let viewModel: DetailsViewModel
	init(viewModel: DetailsViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	deinit {
		delegate?.removeDetails()
	}
	
	override func loadView() {
		view = contentView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		bind()
	}
	
	private func bind() {
		
		let output = viewModel.transform()
		self.contentView.bind(with: output)
	}
}
