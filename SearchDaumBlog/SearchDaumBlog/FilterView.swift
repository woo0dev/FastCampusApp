//
//  FilterView.swift
//  SearchDaumBlog
//
//  Created by woo0 on 2022/10/03.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

class FilterView: UITableViewHeaderFooterView {
	let disposeBag = DisposeBag()
	
	let sortButton = UIButton()
	let bottomBorder = UIView()
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		
		attribute()
		layout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func bind(_ viewModel: FilterViewModel) {
		sortButton.rx.tap
			.bind(to: viewModel.sortButtonTapped)
			.disposed(by: disposeBag)
	}
	
	private func attribute() {
		sortButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
		bottomBorder.backgroundColor = .lightGray
	}
	
	private func layout() {
		[sortButton, bottomBorder].forEach { addSubview($0) }
		
		sortButton.snp.makeConstraints {
			$0.top.equalToSuperview()
			$0.trailing.equalToSuperview().inset(12)
			$0.width.height.equalTo(20)
		}
		
		bottomBorder.snp.makeConstraints {
			$0.top.equalTo(sortButton.snp.bottom)
			$0.leading.trailing.bottom.equalToSuperview()
			$0.height.equalTo(0.5)
		}
	}
}