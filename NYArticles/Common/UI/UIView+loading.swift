//
//  UIView+loading.swift
//  NYArticles
//
//  Created by Ahmad Almasri on 5/23/20.
//  Copyright © 2020 Ahmad Almasri. All rights reserved.
//

import UIKit

public extension UIView {
	
	func showLoader(_ background: UIColor? = UIColor.white,
					indicatorColor: UIColor = UIColor.black) {
		let bounds = UIScreen.main.bounds
		let loaderView  = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
		loaderView.tag = -3 + self.tag
		loaderView.backgroundColor = background
		let loader = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
		loader.center = loaderView.center
		loader.color = indicatorColor
		loader.startAnimating()
		loaderView.addSubview(loader)
		self.addSubview(loaderView)
		
	}
	
	func dismissLoader() {
		self.viewWithTag(-3 + self.tag)?.removeFromSuperview()
	}
}
