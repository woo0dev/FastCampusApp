//
//  AlertActionConvertible.swift
//  SearchDaumBlog
//
//  Created by woo0 on 2022/10/03.
//

import UIKit

protocol AlertActionConvertible {
	var title: String { get }
	var style: UIAlertAction.Style { get }
}
