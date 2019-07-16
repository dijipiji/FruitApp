//
//  BaseViewController.swift
//  FruitApp
//
//  Created by Jamie Lemon on 16/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = StyleSheet.barBackgroundColor
        self.navigationController?.navigationBar.tintColor = StyleSheet.textColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:StyleSheet.textColor]
    }
    

}
