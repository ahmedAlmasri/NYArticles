//
//  ViewController.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/21/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import UIKit
import RxCocoa

protocol HomeControllerDelegate: class {
	
	func showDetails(with article: Article)
}

class HomeController: UIViewController {
	
	public weak var delegate: HomeControllerDelegate?

	private let contentView = HomeView()
	private let viewModel: HomeViewModel
	
	init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		
		view = contentView
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		bind()
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationItem.title = "Articles"
	}
	
	private func bind() {
		
		let trigger = rx.sentMessage(#selector(UIViewController.viewDidLoad)).map {_ in }
			.asDriver(onErrorJustReturn: ())
		
		let input = HomeViewModel.Input(fetchTrigger: trigger, selection: contentView.selection)
		
        let output = viewModel.transform(input: input)

		self.contentView.bind(with: output, controller: self)

	}
}
