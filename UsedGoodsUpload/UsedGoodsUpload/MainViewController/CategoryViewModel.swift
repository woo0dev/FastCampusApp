//
//  CategoryViewModel.swift
//  UsedGoodsUpload
//
//  Created by woo0 on 2022/11/04.
//

import RxSwift
import RxCocoa

struct CategoryViewModel {
	let disposeBag = DisposeBag()
	
	let cellData: Driver<[Category]>
	let pop: Signal<Void>
	let itemSelected = PublishRelay<Int>()
	
	let selectedCategory = PublishSubject<Category>()
	
	init() {
		let categories = [
			Category(id: 1, name: "디지털"),
			Category(id: 2, name: "게임"),
			Category(id: 3, name: "스포츠"),
			Category(id: 4, name: "유아"),
		]
		
		self.cellData = Driver.just(categories)
		
		self.itemSelected
			.map { categories[$0] }
			.bind(to: selectedCategory)
			.disposed(by: disposeBag)
		
		self.pop = itemSelected
			.map { _ in Void() }
			.asSignal(onErrorSignalWith: .empty())
	}
}
