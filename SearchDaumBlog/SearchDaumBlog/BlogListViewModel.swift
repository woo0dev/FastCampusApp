//
//  BlogListViewModel.swift
//  SearchDaumBlog
//
//  Created by woo0 on 2022/10/06.
//

import RxCocoa
import RxSwift

struct BlogListViewModel {
	let filterViewModel = FilterViewModel()
	
	let blogCellData = PublishSubject<[BlogListCellData]>()
	let cellData: Driver<[BlogListCellData]>
	
	init() {
		self.cellData = blogCellData
			.asDriver(onErrorJustReturn: [])
	}
}
