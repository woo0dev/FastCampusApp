//
//  ViewController.swift
//  UsedGoodsUpload
//
//  Created by woo0 on 2022/11/04.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class MainViewController: UIViewController {
	let disposeBag = DisposeBag()
	
	let tableView = UITableView()
	let submitButton = UIBarButtonItem()
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		attribute()
		layout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func bind(_ viewModel: MainViewModel) {
		viewModel.cellData
			.drive(tableView.rx.items) { tv, row, data in
				switch row {
				case 0:
					let cell = tv.dequeueReusableCell(withIdentifier: "TitleTextFieldCell", for: IndexPath(row: row, section: 0)) as! TitleTextFieldCell
					cell.selectionStyle = .none
					cell.titleInputField.placeholder = data
					cell.bind(viewModel.titleTextFieldCellViewModel)
					return cell
				case 1:
					let cell = tv.dequeueReusableCell(withIdentifier: "CategoryListCell", for: IndexPath(row: row, section: 0))
					cell.selectionStyle = .none
					cell.textLabel?.text = data
					cell.accessoryType = .disclosureIndicator
					return cell
				case 2:
					let cell = tv.dequeueReusableCell(withIdentifier: "PriceTextFieldCell", for: IndexPath(row: row, section: 0)) as! PriceTextFieldCell
					cell.selectionStyle = .none
					cell.priceInputField.placeholder = data
					cell.bind(viewModel.priceTextFieldCellViewModel)
					return cell
				default:
					return UITableViewCell()
				}
			}
			.disposed(by: disposeBag)
		
		viewModel.presentAlert
			.emit(to: self.rx.setAlert)
			.disposed(by: disposeBag)
		
		viewModel.push
			.drive(onNext: { viewModel in
				let viewController = CategoryListViewController()
				viewController.bind(viewModel)
				self.show(viewController, sender: nil)
			})
			.disposed(by: disposeBag)
		
		tableView.rx.itemSelected
			.map { $0.row }
			.bind(to: viewModel.itemSelected)
			.disposed(by: disposeBag)
		
		submitButton.rx.tap
			.bind(to: viewModel.submitButtonTapped)
			.disposed(by: disposeBag)
	}
	
	private func attribute() {
		title = "중고거래 글쓰기"
		view.backgroundColor = .white
		
		submitButton.title = "제출"
		submitButton.style = .done
		
		navigationItem.setRightBarButton(submitButton, animated: true)
		
		tableView.backgroundColor = .white
		tableView.separatorStyle = .singleLine
		tableView.tableFooterView = UIView()
		
		tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: "TitleTextFieldCell")
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryListCell")
		tableView.register(PriceTextFieldCell.self, forCellReuseIdentifier: "PriceTextFieldCell")
	}
	
	private func layout() {
		view.addSubview(tableView)
		
		tableView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}

}

typealias Alert = (title: String, message: String?)
extension Reactive where Base: MainViewController {
	var setAlert: Binder<Alert> {
		return Binder(base) { base, data in
			let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
			let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
			alertController.addAction(action)
			base.present(alertController, animated: true, completion: nil)
		}
	}
}
