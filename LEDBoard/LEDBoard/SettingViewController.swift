//
//  SettingViewController.swift
//  LEDBoard
//
//  Created by woo0 on 2022/07/06.
//

import UIKit

protocol LEDBoardSettingDelegate: AnyObject {
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor)
}

class SettingViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    
    weak var delegate: LEDBoardSettingDelegate?
    var ledText: String?
    var textColor: UIColor = .yellow
    var backgroundColor: UIColor = .black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    private func configureView() {
        if let ledText = ledText {
            textField.text = ledText
        }
        changeTextColor(color: textColor)
        changeBackgroundColor(color: backgroundColor)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        delegate?.changedSetting(text: textField.text, textColor: textColor, backgroundColor: backgroundColor)
    }
    @IBAction func tapTextColorButton(_ sender: UIButton) {
//        if sender == self.yellowButton {
//            self.changeTextColor(color: .yellow)
//        } else if sender == self.purpleButton {
//            self.changeTextColor(color: .purple)
//        } else if sender == self.greenButton {
//            self.changeTextColor(color: .green)
//        }
        switch sender {
        case yellowButton:
            changeTextColor(color: .yellow)
            textColor = .yellow
        case purpleButton:
            changeTextColor(color: .purple)
            textColor = .purple
        case greenButton:
            changeTextColor(color: .green)
            textColor = .green
        default:
            changeTextColor(color: .gray)
            textColor = .gray
        }
    }
    @IBAction func tapBackgroundColorButton(_ sender: UIButton) {
        switch sender {
        case blackButton:
            changeBackgroundColor(color: .black)
            backgroundColor = .black
        case blueButton:
            changeBackgroundColor(color: .blue)
            backgroundColor = .blue
        case orangeButton:
            changeBackgroundColor(color: .orange)
            backgroundColor = .orange
        default:
            changeBackgroundColor(color: .white)
            backgroundColor = .white
        }
    }
    
    private func changeTextColor(color: UIColor) {
        yellowButton.alpha = color == UIColor.yellow ? 1 : 0.5
        purpleButton.alpha = color == UIColor.purple ? 1 : 0.5
        greenButton.alpha = color == UIColor.green ? 1 : 0.5
    }
    
    private func changeBackgroundColor(color: UIColor) {
        blackButton.alpha = color == UIColor.black ? 1 : 0.5
        blueButton.alpha = color == UIColor.blue ? 1 : 0.5
        orangeButton.alpha = color == UIColor.orange ? 1 : 0.5
    }
}
