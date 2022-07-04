//
//  AddAlertViewController.swift
//  Drink
//
//  Created by woo0 on 2022/07/05.
//

import UIKit

class AddAlertViewController: UIViewController {
    var pickerDate: ((_ date: Date) -> Void)?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        pickerDate?(datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
}
