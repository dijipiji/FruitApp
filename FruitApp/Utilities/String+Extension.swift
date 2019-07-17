//
//  String+Extension.swift
//  FruitApp
//
//  Created by Jamie Lemon on 17/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import Foundation

extension String {
    func localized(_ lang:String = "en") ->String {
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
