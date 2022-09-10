//
//  CovidDetailViewController.swift
//  GoodByeCovid19
//
//  Created by woo0 on 2022/09/09.
//

import UIKit

class CovidDetailViewController: UITableViewController {
	@IBOutlet weak var newCaseCell: UITableViewCell!
	@IBOutlet weak var totalCaseCell: UITableViewCell!
	@IBOutlet weak var recoveredCell: UITableViewCell!
	@IBOutlet weak var deathCell: UITableViewCell!
	@IBOutlet weak var percentageCell: UITableViewCell!
	@IBOutlet weak var overseasInflowCell: UITableViewCell!
	@IBOutlet weak var regionalOutbreakCell: UITableViewCell!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
    }

}
