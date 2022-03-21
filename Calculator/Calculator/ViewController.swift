//
//  ViewController.swift
//  Calculator
//
//  Created by woo0 on 2022/03/17.
//

import UIKit

enum Operation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case unknown
}

class ViewController: UIViewController {
    @IBOutlet weak var numberOutputLabel: UILabel!
    
    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""
    var result = ""
    var currentOperation: Operation = .unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.titleLabel?.text else { return }
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberOutputLabel.text = displayNumber
        }
    }
    
    @IBAction func tapClearButton(_ sender: UIButton) {
        
    }
    
    @IBAction func tapDotButton(_ sender: UIButton) {
    }
    
    @IBAction func tapDivideButton(_ sender: UIButton) {
    }
    
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
    }
    
    @IBAction func tapSubtractButton(_ sender: UIButton) {
    }
    
    @IBAction func tapAddButton(_ sender: UIButton) {
    }
    
    @IBAction func tapEqualButton(_ sender: UIButton) {
    }
    
}

