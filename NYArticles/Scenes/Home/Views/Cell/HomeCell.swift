//
//  HomeCell.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
	
	static var identifier: String {
		
		return "\(Self.self)"
	}
	static var nib: UINib {
		UINib(nibName: HomeCell.identifier, bundle: nil)
	}
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var creatorLabel: UILabel!
	@IBOutlet weak var sectionLabel: UILabel!
	@IBOutlet weak var publishedDateLabel: UILabel!
	
	func bind(article: Article) {
		
		titleLabel.text = article.title
		creatorLabel.text = article.byline
		sectionLabel.text = article.section
		publishedDateLabel.text = article.publishedDate
	}

}
