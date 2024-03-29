//
//  ViewController.swift
//  Diary
//
//  Created by woo0 on 2022/07/13.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var collectionView: UICollectionView!

	private var diaryList = [Diary]() {
		didSet {
			saveDiaryList()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		loadDiaryList()
		configureCollectionView()
	}
	
	private func configureCollectionView() {
		collectionView.collectionViewLayout = UICollectionViewFlowLayout()
		collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		collectionView.delegate = self
		collectionView.dataSource = self
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let writeDiaryViewController = segue.destination as? WriteDiaryViewController {
			writeDiaryViewController.delegate = self
		}
	}
	
	private func saveDiaryList() {
		let date = diaryList.map {
			[
				"title": $0.title,
				"contents": $0.contents,
				"date": $0.date,
				"isStar": $0.isStar
			]
		}
		let userDefaults = UserDefaults.standard
		userDefaults.set(date, forKey: "diaryList")
	}
	
	private func loadDiaryList() {
		let userDefaults = UserDefaults.standard
		guard let data = userDefaults.object(forKey: "diaryList") as? [[String: Any]] else { return }
		diaryList = data.compactMap {
			guard let title = $0["title"] as? String else { return nil }
			guard let contents = $0["contents"] as? String else { return nil }
			guard let date = $0["date"] as? Date else { return nil }
			guard let isStar = $0["isStar"] as? Bool else { return nil }
			return Diary(title: title, contents: contents, date: date, isStar: isStar)
		}
		diaryList = diaryList.sorted(by: {
			$0.date.compare($1.date) == .orderedDescending
		})
	}
	
	private func dateToString(date: Date) -> String {
		let formmater = DateFormatter()
		formmater.dateFormat = "yy년 MM월 dd일(EEEEE)"
		formmater.locale = Locale(identifier: "ko_KR")
		return formmater.string(from: date)
	}
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return diaryList.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else { return UICollectionViewCell() }
		let diary = diaryList[indexPath.row]
		cell.titleLabel.text = diary.title
		cell.dateLabel.text = dateToString(date: diary.date)
		return cell
	}
}

extension ViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: UIScreen.main.bounds.width/2-20, height: 200)
	}
}

extension ViewController: WriteDiaryViewDelegate {
	func didSelectRegister(diary: Diary) {
		diaryList.append(diary)
		collectionView.reloadData()
	}
}
