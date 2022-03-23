//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by woo0 on 2022/03/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navigation Bar 숨기기
        navigationController?.navigationBar.isHidden = true
    }
}
