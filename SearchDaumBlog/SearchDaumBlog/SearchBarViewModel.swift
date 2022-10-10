//
//  SearchBarViewModel.swift
//  SearchDaumBlog
//
//  Created by woo0 on 2022/10/04.
//

import RxCocoa
import RxSwift

struct SearchBarViewModel {
	let queryText = PublishRelay<String?>()
	let searchButtonTapped = PublishRelay<Void>()
	let shouldLoadResult: Observable<String>
	
	init() {
		self.shouldLoadResult = searchButtonTapped
			.withLatestFrom(queryText) { $1 ?? "" }
			.filter { !$0.isEmpty }
			.distinctUntilChanged()
	}
}
