//
//  MainViewController.swift
//  SearchDaumBlog
//
//  Created by woo0 on 2022/10/03.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

class MainViewController: UIViewController {
	let disposeBag = DisposeBag()
	
	let searchBar = SearchBar()
	let listView = BlogListView()
	
	let alertActionTapped = PublishRelay<AlertAction>()
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		attribute()
		layout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	func bind(_ viewModel: MainViewModel) {
		
	}
	
	private func attribute() {
		title = "다음 블로그 검색"
		view.backgroundColor = .systemBackground
	}
	
	private func layout() {
		[searchBar, listView].forEach { view.addSubview($0) }
		
		searchBar.snp.makeConstraints {
			$0.top.equalTo(view.safeAreaLayoutGuide)
			$0.leading.trailing.equalToSuperview()
		}
		
		listView.snp.makeConstraints {
			$0.top.equalTo(searchBar.snp.bottom)
			$0.leading.trailing.bottom.equalToSuperview()
		}
	}
}

extension MainViewController {
	typealias Alert = (title: String?, message: String?, actions: [AlertAction], style: UIAlertController.Style)
	
	enum AlertAction: AlertActionConvertible {
		case title, datetime, cancel
		case confirm
		
		var title: String {
			switch self {
			case .title:
				return "Title"
			case .datetime:
				return "Datetime"
			case .cancel:
				return "취소"
			case .confirm:
				return "확인"
			}
		}
		
		var style: UIAlertAction.Style {
			switch self {
			case .title, .datetime:
				return .default
			case .cancel, .confirm:
				return .cancel
			}
		}
	}
	
	func presentAlertController<Action: AlertActionConvertible>(_ alertController: UIAlertController, actions: [Action]) -> Signal<Action> {
		if actions.isEmpty { return .empty() }
		return Observable
			.create { [weak self] observer in
				guard let self = self else { return Disposables.create() }
				for action in actions {
					alertController.addAction(UIAlertAction(title: action.title, style: action.style, handler: { _ in
						observer.onNext(action)
						observer.onCompleted()
					}))
				}
				self.present(alertController, animated: true, completion: nil)
				
				return Disposables.create {
					alertController.dismiss(animated: true, completion: nil)
				}
			}
			.asSignal(onErrorSignalWith: .empty())
	}
}
