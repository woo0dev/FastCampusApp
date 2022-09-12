//
//  ViewController.swift
//  GoodByeCorona19
//
//  Created by woo0 on 2022/09/09.
//

import Alamofire
import Charts
import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var totalCaseLabel: UILabel!
	@IBOutlet weak var newCaseLabel: UILabel!
	@IBOutlet weak var pieChartView: PieChartView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.fetchCovidOverview(completionHandler: { [weak self] result in
			guard let self = self else { return }
			switch result {
			case let .success(result):
				self.configureStackView(koreaCovidOverview: result.korea)
				let covidOverviewList = self.makeCovidOverviewList(cityCovidOverview: result)
				self.configureChartView(covidOverviewList: covidOverviewList)
			case let .failure(error):
				debugPrint("error \(error)")
			}
		})
	}
	
	func configureChartView(covidOverviewList: [CovidOverview]) {
		let entries = covidOverviewList.compactMap { [weak self] overview -> PieChartDataEntry? in
			guard let self = self else { return nil }
			return PieChartDataEntry(value: removeFormatString(string: overview.newCase), label: overview.countryName, data: overview)
		}
		let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
		dataSet.sliceSpace = 1
		dataSet.entryLabelColor = .white
		dataSet.xValuePosition = .outsideSlice
		dataSet.valueLinePart1OffsetPercentage = 0.8
		dataSet.valueLinePart1Length = 0.2
		dataSet.valueLinePart2Length = 0.3
		dataSet.colors = ChartColorTemplates.vordiplom() + ChartColorTemplates.joyful() + ChartColorTemplates.liberty() + ChartColorTemplates.pastel() + ChartColorTemplates.material()
		pieChartView.data = PieChartData(dataSet: dataSet)
	}
	
	func configureStackView(koreaCovidOverview: CovidOverview) {
		self.totalCaseLabel.text = "\(koreaCovidOverview.totalCase)먕"
		self.newCaseLabel.text = "\(koreaCovidOverview.newCase)명"
	}

	func fetchCovidOverview(completionHandler: @escaping (Result<CityCovidOverview, Error>) -> Void) {
		let url = "https://api.corona-19.kr/korea/country/new/"
		let param = [
			"serviceKey": "SaV6rcxZN3m4Gn81il5UTIPkyR2Ds9jg7"
		]
		
		AF.request(url, method: .get, parameters: param)
			.responseData(completionHandler: { response in
				switch response.result {
				case let .success(data):
					do {
						let decoder = JSONDecoder()
						let result = try decoder.decode(CityCovidOverview.self, from: data)
						completionHandler(.success(result))
					} catch {
						completionHandler(.failure(error))
					}
				case let .failure(error):
					completionHandler(.failure(error))
				}
			})
	}
	
	func makeCovidOverviewList(cityCovidOverview: CityCovidOverview) -> [CovidOverview] {
		return [
			cityCovidOverview.seoul,
			cityCovidOverview.busan,
			cityCovidOverview.daegu,
			cityCovidOverview.incheon,
			cityCovidOverview.gwangju,
			cityCovidOverview.daejeon,
			cityCovidOverview.ulsan,
			cityCovidOverview.sejong,
			cityCovidOverview.gyeonggi,
			cityCovidOverview.chungbuk,
			cityCovidOverview.chungnam,
			cityCovidOverview.gyeongbuk,
			cityCovidOverview.gyeongnam,
			cityCovidOverview.jeju
		]
	}

	func removeFormatString(string: String) -> Double {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		return formatter.number(from: string)?.doubleValue ?? 0
	}
}

