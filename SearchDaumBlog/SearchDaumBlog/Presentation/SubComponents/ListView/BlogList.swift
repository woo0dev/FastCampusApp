//
//  BlogList.swift
//  SearchDaumBlog
//
//  Created by woo0 on 2022/10/03.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

class BlogListView: UITableView {
	let disposeBag = DisposeBag()
	let headerView = FilterView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 50)))
	
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		
		attribute()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func bind(_ viewModel: BlogListViewModel) {
		viewModel.cellData
			.drive(self.rx.items) { tv, row, data in
				let index = IndexPath(row: row, section: 0)
				let cell = tv.dequeueReusableCell(withIdentifier: "BlogListCell", for: index) as! BlogListCell
				cell.setData(data)
				return cell
			}
			.disposed(by: disposeBag)
	}
	
	private func attribute() {
		self.backgroundColor = .systemBackground
		self.register(BlogListCell.self, forCellReuseIdentifier: "BlogListCell")
		self.separatorStyle = .singleLine
		self.rowHeight = 100
		self.tableHeaderView = headerView
	}
}
