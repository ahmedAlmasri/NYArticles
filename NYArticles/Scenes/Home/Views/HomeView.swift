//
//  HomeView.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class HomeView: UIView {
	
	private let disposeBag = DisposeBag()
	
	private lazy var tableView: UITableView = {
		
		let tableView = UITableView()
		
		return tableView
	}()
	
	init() {
		super.init(frame: .zero)
		self.backgroundColor = .white
		setupViews()
		configureTableView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupViews() {
		self.addSubview(tableView)
		tableView.snp.makeConstraints {
			
			$0.top.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
		}
	}
	
	private func configureTableView() {
		tableView.register(HomeCell.nib, forCellReuseIdentifier: HomeCell.identifier)
	}
	
	func bind(with output: HomeViewModel.Output, controller: UIViewController) {
		
		output.articles.drive(tableView.rx
			.items(cellIdentifier: HomeCell.identifier, cellType: HomeCell.self)) { _, viewModel, cell in
				cell.bind(article: viewModel)
		}.disposed(by: disposeBag)
		
		output.error.drive(errorBinding(controller)).disposed(by: disposeBag)
		
		output.fetching.drive(loading()).disposed(by: disposeBag)
	}
	private func loading() -> Binder<Bool> {
	
		return Binder(self) { (_, isLoading) in
			
			isLoading ? self.showLoader() : self.dismissLoader()
		}
	}
	
	private func errorBinding(_ controller: UIViewController) -> Binder<Error> {
		return Binder(self, binding: { (_, error) in
			let alert = UIAlertController(title: "Oops",
										  message: error.localizedDescription,
										  preferredStyle: .alert)
			let action = UIAlertAction(title: "Ok",
									   style: UIAlertAction.Style.cancel,
									   handler: nil)
			alert.addAction(action)
			controller.present(alert, animated: true, completion: nil)
		})
	}
}
