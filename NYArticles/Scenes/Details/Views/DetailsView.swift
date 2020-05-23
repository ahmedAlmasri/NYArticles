//
//  DetailsView.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsView: UIView {
	
	private let disposeBag = DisposeBag()

	private lazy var mainStackView: UIStackView = {
		let mainStackView = UIStackView(arrangedSubviews: [titleLabel, abstractLabel, publisherStackView])
		mainStackView.axis = .vertical
		mainStackView.alignment = .fill
		mainStackView.spacing = 15
		return mainStackView
	}()
	
	lazy var titleLabel: UILabel = {
		var titleLabel = UILabel()
		titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
		titleLabel.numberOfLines = 0
		return titleLabel
	}()
	
	lazy var abstractLabel: UILabel = {
		var abstractLabel = UILabel()
		abstractLabel.numberOfLines = 0
		return abstractLabel
	}()
	
	lazy var sectionLabel: UILabel = {
		var sectionLabel = UILabel()
		sectionLabel.font = UIFont.systemFont(ofSize: 12)
		sectionLabel.numberOfLines = 0
		return sectionLabel
	}()
	
	lazy var dateLabel: UILabel = {
		var dateLabel = UILabel()
		dateLabel.font = UIFont.systemFont(ofSize: 12)
		dateLabel.numberOfLines = 0
		return dateLabel
	}()
	
	 lazy var publisherStackView: UIStackView = {
		let publisherStackView = UIStackView(arrangedSubviews: [sectionLabel,
														   dateLabel])
		publisherStackView.axis = .horizontal
		
		publisherStackView.distribution = .equalSpacing
		
		return publisherStackView
	}()
	
	init() {
		super.init(frame: .zero)
		self.backgroundColor = .white
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		return nil
	}
	
	private func setupViews() {
		
		self.addSubview(mainStackView)
		
		mainStackView.snp.makeConstraints {
			$0.right.equalTo(self.safeAreaLayoutGuide).offset(-28)
			$0.left.equalTo(self.safeAreaLayoutGuide).offset(28)
			$0.top.equalTo(self.safeAreaLayoutGuide).offset(28)
		}
		
	}
	
	func bind(with output: DetailsViewModel.Output) {
		
		let bind = Binder<Article>(self) { [weak self] (_, article) in
			self?.titleLabel.text = article.title
			self?.abstractLabel.text = article.abstract
			self?.dateLabel.text = article.publishedDate
			self?.sectionLabel.text = article.section
			print(article.url)
		}
		output.article.drive(bind).disposed(by: disposeBag)

	}
}
