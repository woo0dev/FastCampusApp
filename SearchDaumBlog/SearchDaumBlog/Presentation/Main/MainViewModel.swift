//
//  MainViewModel.swift
//  SearchDaumBlog
//
//  Created by woo0 on 2022/10/06.
//

import RxCocoa
import RxSwift
import UIKit

struct MainViewModel {
	let disposeBag = DisposeBag()
	
	let blogListViewModel = BlogListViewModel()
	let searchBarViewModel = SearchBarViewModel()
	
	let alertActionTapped = PublishRelay<MainViewController.AlertAction>()
	let shouldPresentAlert: Signal<MainViewController.Alert>
	
	init() {
		let blogResult = searchBarViewModel.shouldLoadResult
			.flatMap { query in
				SearchBlogNetwork().searchBlog(query: query)
			}
			.share()
		
		let blogValue = blogResult
			.compactMap { data -> DKBlog? in
				guard case .success(let value) = data else {
					return nil
				}
				
				return value
			}
		
		let blogError = blogResult
			.compactMap { data -> String? in
				guard case .failure(let error) = data else {
					return nil
				}
				
				return error.localizedDescription
			}
		
		let cellData = blogValue
			.map { blog -> [BlogListCellData] in
				return blog.documents
					.map { doc in
						let thumbnailURL = URL(string: doc.thumbnail ?? "")
						return BlogListCellData(thumbnailURL: thumbnailURL, name: doc.name, title: doc.title, datetime: doc.datetime)
					}
			}
		
		let sortedType = alertActionTapped
			.filter {
				switch $0 {
				case .title, .datetime:
					return true
				default:
					return false
				}
			}
			.startWith(.title)
		
		Observable
			.combineLatest(
				sortedType,
				cellData
			) { type, data -> [BlogListCellData] in
				switch type {
				case .title:
					return data.sorted { $0.title ?? "" < $1.title ?? "" }
				case .datetime:
					return data.sorted { $0.datetime ?? Date() > $1.datetime ?? Date() }
				default:
					return data
				}
			}
			.bind(to: blogListViewModel.blogCellData)
			.disposed(by: disposeBag)
		
		let alertSheetForSorting = blogListViewModel.filterViewModel.sortButtonTapped
			.map { _ -> MainViewController.Alert in
				return (title: nil, message: nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
			}
		
		alertSheetForSorting
			.asSignal(onErrorSignalWith: .empty())
			.flatMapLatest { alert -> Signal<MainViewController.AlertAction> in
				let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.style)
				return self.presentAlertController(alertController, actions: alert.actions)
			}
			.emit(to: alertActionTapped)
			.disposed(by: disposeBag)
	}
}
