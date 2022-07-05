//
//  ViewController.swift
//  LEDBoard
//
//  Created by woo0 on 2022/07/06.
//

import UIKit

class ViewController: UIViewController, LEDBoardSettingDelegate {
    @IBOutlet weak var contentsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentsLabel.textColor = .yellow
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingViewController = segue.destination as? SettingViewController {
            settingViewController.delegate = self
            settingViewController.ledText = contentsLabel.text
            settingViewController.textColor = contentsLabel.textColor
            settingViewController.backgroundColor = view.backgroundColor ?? .black
        }
    }

    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        if let text = text {
            contentsLabel.text = text
        }
        contentsLabel.textColor = textColor
        view.backgroundColor = backgroundColor
    }
}

