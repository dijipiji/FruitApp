//
//  BaseViewController.swift
//  FruitApp
//
//  Created by Jamie Lemon on 16/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let eventLogger:EventLogger = EventLogger()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = StyleSheet.barBackgroundColor
        self.navigationController?.navigationBar.tintColor = StyleSheet.textColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:StyleSheet.textColor]
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.view.frame = CGRect(origin: self.view.frame.origin, size: size)
        render()
    }
    
    /**
     * Override this as required in your superclass
     */
    func render() {
        
    }
    
    func renderComplete() {
        eventLogger.endDate = Date()
        eventLogger.sendDisplayEvent()
    }
    
}


